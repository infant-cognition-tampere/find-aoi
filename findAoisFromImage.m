function aois = findAoisFromImage(imagefile, propertystring, ...
                                  mergetreshold, minsize, maxsize, roi)
    % Return aois found for an imagefile. Aoi is defined as
    % [xmin xmax ymin ymax] and values ranging 0..1 (normalized).

    detector = vision.CascadeObjectDetector(propertystring);
    detector.MergeThreshold = mergetreshold;
    detector.MinSize = minsize;
    detector.MaxSize = maxsize;
        
    % read image
    I = imread(imagefile);

    % find properties from the image
    % if roi parameter contains values and not empty array -> use roi
    if ~isempty(roi)
        detector.UseROI = 1;
        bboxes = detector(I, roi);
    else
        bboxes = detector(I);
    end

    
    % calculate aois from bboxes-matlab aoi-list
    [hi, wi, ~] = size(I);
    aois = [];
    for i=1:size(bboxes, 1)
        bbox = bboxes(i,:);
        aois(end+1,:) = [bbox(1)/wi (bbox(1)+bbox(3))/wi ...
                         bbox(2)/hi (bbox(2)+bbox(4))/hi];
    end
    
    % draw image
    IFaces = insertObjectAnnotation(I, 'rectangle', bboxes, propertystring);
    imshow(IFaces);