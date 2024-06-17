classdef DTEDDatastore < matlab.io.Datastore
% DTEDDatastore Datastore for a collection of DTED files

    properties (Access = private)
        CurrentFileIndex double
        FileSet matlab.io.datastore.DsFileSet
    end

    methods

        function dtedDS = DTEDDatastore(location,extension)
            % Create a DTEDDatastore object
            arguments
                location {mustBeFolder}
                extension {mustBeTextScalar}
            end

            dtedDS.FileSet = matlab.io.datastore.DsFileSet(location, ...
                FileExtensions=extension,IncludeSubfolders=true);
            
            reset(dtedDS)
        end

        function tf = hasdata(dtedDS)
            % Return true if there is data available to read in the
            % datastore
            tf = hasfile(dtedDS.FileSet);
        end

        function [data,info] = read(dtedDS)
            % Read data and information from the next file in the datastore

            % If there is no data to read, issue error
            if ~hasdata(dtedDS)
                error(sprintf("No more data to read. Reset datastore " + ...
                    "to initial state by using reset."))  
            end

            % Get name of next file
            fileInfo = nextfile(dtedDS.FileSet);
            filename = fileInfo.FileName;

            % Read file
            [Z,R] = readgeoraster(filename,OutputType="double");

            % Get information about file
            info = georasterinfo(filename);

            % Replace missing data with NaN values
            Z = standardizeMissing(Z,info.MissingDataIndicator);

            % Collect array and raster reference object into cell array
            data = {Z,R};

            % Increment index of next file to read
            dtedDS.CurrentFileIndex = dtedDS.CurrentFileIndex + 1;
        end

        function reset(dtedDS)
            % Reset datastore to initial state
            reset(dtedDS.FileSet)
            dtedDS.CurrentFileIndex = 1;
        end

        function [Z,R] = readMergedTiles(dtedDS)
            % Read data from all files and merge into one array and one
            % raster reference object

            % Read all data
            alldata = readall(dtedDS)';

            % Reshape data
            alldata = alldata(:)';

            % Extract data from cell array and merge data
            [Z,R] = mergetiles(alldata{:});
        end

    end

    methods (Hidden = true)
        function frac = progress(dtedDS)
            % Determine percentage of data read from datastore
            if hasdata(dtedDS)
                frac = (dtedDS.CurrentFileIndex-1)/dtedDS.FileSet.NumFiles;
            else
                frac = 1;
            end
        end
    end

    methods (Access = protected)
        % Enable class to create deep copy of datastore object
        function dscopy = copyElement(ds)
            dscopy = copyElement@matlab.mixin.Copyable(ds);
            dscopy.FileSet = copy(ds.FileSet);
        end
    end
end