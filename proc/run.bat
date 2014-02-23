conv.exe test.bmp | Threshold | conv.exe thresholded.bmp o
conv.exe test.bmp | Filter 2 a | conv.exe averaging_filtered.bmp o
conv.exe test.bmp | Filter 2 g | conv.exe gaussian_filtered.bmp o
conv.exe test.bmp | Filter 2 m | conv.exe median_filtered.bmp o
conv.exe test.bmp | Filter 2 e | conv.exe edge_preserving_filtered.bmp o
conv.exe test.bmp | Edge r | conv.exe robert_edge.bmp o
conv.exe test.bmp | Edge s | conv.exe sobel_edge.bmp o
conv.exe test.bmp | Edge p | conv.exe prewitt_edge.bmp o
