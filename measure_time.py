from fastofreader import read_faces
from fastofreader import read_points
import time

start_time = time.perf_counter()
faces = read_faces("/data/faces")
end_time = time.perf_counter()
print(f"Time taken: {end_time - start_time} seconds")
print(len(faces))

start_time = time.perf_counter()
points = read_points("/data/points")
end_time = time.perf_counter()
print(f"Time taken: {end_time - start_time} seconds")
print(len(points))