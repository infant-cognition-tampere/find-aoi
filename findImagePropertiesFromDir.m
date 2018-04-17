function findImagePropertiesFromDir(directorypath, propertyname)
    % Process a directory full of (only) imagefiles and find image
    % properties to all of them. Place results to a csv-file.

    % parameters for cascade object detector
    mergetreshold = 2;      % default 4
    minsize = [100 100];    % default []
    maxsize = [200 200];    % default []

    % get filenames from directory
    files = dir(directorypath);
    
    % remove . and .. from the results, quickfix.
    files(1:3) = [];
    
    % loop files, perform propertyfinding
    % round-counter
    rc = 1;
    for f = 1:length(files)
        filepath = [directorypath filesep files(f).name];
        aoi = findAoisFromImage(filepath, propertyname, mergetreshold, minsize, maxsize);
        frame(rc) = rc;
        aoi_as_string{rc} = num2str(aoi);
        rc = rc+1;
    end
    
    % save aoi data
    csvheaders = {'frame', 'face_aoi'};
    saveCsvFile([directorypath filesep 'aois.csv'], csvheaders, frame,  aoi_as_string);
end