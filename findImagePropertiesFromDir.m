
function findImagePropertiesFromDir(directorypath, propertyname)

folder = '/Users/jml/Desktop/sl_faces/aois/';

    mergetreshold = 2;  % default 4
    minsize = [100 100];       % default []
    maxsize = [200 200];       % default []

    % get filenames from directory
    files = dir(directorypath);
    
    % remove . and .. from the results
    files(1:3) = [];
    
    % loop files, perform propertyfinding
    
    % round-counter
    rc = 1;

    for f=1:length(files)
        filepath = [directorypath filesep files(f).name];
        aoi= findAoisFromImage(filepath, propertyname, mergetreshold, minsize, maxsize);
        frame(rc)=rc;
        rc=rc+1;
        aoi2{rc}=num2str(aoi)
    end
    
%sace aoi data
disp('Writing datafile...');
csvheaders = {'frame', 'face_aoi'};
saveCsvFile([folder 'aoi_facevideo6.csv'], csvheaders, frame,  aoi2);

disp('All done')
end