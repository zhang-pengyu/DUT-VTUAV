function rect = corner2rect(points)

if size(points,1) ~= 1
    disp('error!');
    return;
end

left = (points(1));
right = (points(3));

bottom = (points(6));
top = (points(2));

rect = round([left, top, right - left , bottom - top ]);
