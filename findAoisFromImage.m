function aois = findAoisFromImage(imagefile, propertystring, mergetreshold, minsize, maxsize)
    % Return aois found for an imagefile. Aoi is defined as
    % [xmin xmax ymin ymax] and values ranging 0..1 (normalized).

    propertyDetector = vision.CascadeObjectDetector(propertystring);
    propertyDetector.MergeThreshold = mergetreshold;
    propertyDetector.MinSize = minsize;
    propertyDetector.MaxSize = maxsize;
    
    % read image
    I = imread(imagefile);

    % find properties from the image
    bboxes = step(propertyDetector, I);
    
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