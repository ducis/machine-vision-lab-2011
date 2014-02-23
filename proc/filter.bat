conv.exe test.bmp | Filter 1 a | conv.exe averaging_filtered_3x3.bmp o
conv.exe test.bmp | Filter 2 a | conv.exe averaging_filtered_5x5.bmp o
conv.exe test.bmp | Filter 3 a | conv.exe averaging_filtered_7x7.bmp o
conv.exe test.bmp | Filter 1 m | conv.exe median_filtered_3x3.bmp o
conv.exe test.bmp | Filter 2 m | conv.exe median_filtered_5x5.bmp o
conv.exe test.bmp | Filter 3 m | conv.exe median_filtered_7x7.bmp o
