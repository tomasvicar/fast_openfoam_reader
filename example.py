# Python side
from fastofreader import read_faces, read_faces_from_text
from fastofreader import read_points, read_points_from_text

faces = read_faces("faces_test_file")
print(faces)

points = read_points("points_test_file")
print(points)




