# Python side
from fastofreader import read_faces, read_faces_from_text
from fastofreader import read_points, read_points_from_text
from fastofreader import read_boundary

faces = read_faces("faces_test_file")
print("faces:", len(faces), "first:", faces[0][:4])

points = read_points("points_test_file")
print("points:", len(points), "first:", points[0])

# Boundary
bounds = read_boundary("boundary_test_file")
first_name = next(iter(bounds))
print("boundary entries:", len(bounds), "first:", first_name, bounds[first_name])




