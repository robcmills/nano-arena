First draft of working gif encoder was super slow:

========== GIF ENCODER PROFILE ==========
Total Time: 78.8661 seconds
Total Memory Delta: 344.38 KB
Image Size: 640x480, Frames: 14

--- Section Breakdown ---
  Frame 1 - Color Quantization     5.6296s (  7.1%)  +4096.12 KB
  Frame 5 - Color Quantization     5.6256s (  7.1%)  +4096.12 KB
  Frame 2 - Color Quantization     5.6212s (  7.1%)  +4096.12 KB
  Frame 8 - Color Quantization     5.6188s (  7.1%)  +4096.12 KB
  Frame 10 - Color Quantization    5.6187s (  7.1%)  +4096.12 KB
  Frame 12 - Color Quantization    5.6164s (  7.1%)  +4096.12 KB
  Frame 14 - Color Quantization    5.6163s (  7.1%)  +4096.12 KB
  Frame 13 - Color Quantization    5.6154s (  7.1%)  +4096.12 KB
  Frame 6 - Color Quantization     5.6126s (  7.1%)  +4096.12 KB
  Frame 3 - Color Quantization     5.6119s (  7.1%)  +4096.12 KB
  Frame 7 - Color Quantization     5.6078s (  7.1%)  +4096.12 KB
  Frame 4 - Color Quantization     5.6071s (  7.1%)  +4096.12 KB
  Frame 11 - Color Quantization    5.6051s (  7.1%)  +4096.12 KB
  Frame 9 - Color Quantization     5.6045s (  7.1%)  +4096.12 KB
  Frame 11 - LZW Compression       0.0176s (  0.0%)  +634.52 KB
  Frame 13 - LZW Compression       0.0175s (  0.0%)  +632.53 KB
  Frame 10 - LZW Compression       0.0173s (  0.0%)  +633.30 KB
  Frame 9 - LZW Compression        0.0172s (  0.0%)  +633.12 KB
  Frame 1 - LZW Compression        0.0169s (  0.0%)  +633.53 KB
  Frame 7 - LZW Compression        0.0168s (  0.0%)  +633.39 KB
  Frame 8 - LZW Compression        0.0168s (  0.0%)  +634.67 KB
  Frame 12 - LZW Compression       0.0167s (  0.0%)  +633.48 KB
  Frame 6 - LZW Compression        0.0167s (  0.0%)  +632.76 KB
  Frame 5 - LZW Compression        0.0167s (  0.0%)  +631.86 KB
  Frame 2 - LZW Compression        0.0165s (  0.0%)  +629.15 KB
  Frame 3 - LZW Compression        0.0165s (  0.0%)  +628.88 KB
  Frame 14 - LZW Compression       0.0165s (  0.0%)  +632.53 KB
  Frame 4 - LZW Compression        0.0164s (  0.0%)  +630.28 KB
  Final Concatenation              0.0001s (  0.0%)  +63.44 KB
  Palette Generation               0.0000s (  0.0%)  +26.16 KB
==========================================


After color quantization optimization:

========== GIF ENCODER PROFILE ==========
Total Time: 1.0856 seconds
Total Memory Delta: 344.38 KB
Image Size: 640x480, Frames: 14

--- Section Breakdown ---
  Frame 1 - Color Quantization     0.0750s (  6.9%)  +4096.12 KB
  Frame 6 - Color Quantization     0.0597s (  5.5%)  +4096.12 KB
  Frame 7 - Color Quantization     0.0574s (  5.3%)  +4096.12 KB
  Frame 3 - Color Quantization     0.0568s (  5.2%)  +4096.12 KB
  Frame 5 - Color Quantization     0.0567s (  5.2%)  +4096.12 KB
  Frame 2 - Color Quantization     0.0566s (  5.2%)  +4096.12 KB
  Frame 10 - Color Quantization    0.0566s (  5.2%)  +4096.12 KB
  Frame 8 - Color Quantization     0.0566s (  5.2%)  +4096.12 KB
  Frame 12 - Color Quantization    0.0565s (  5.2%)  +4096.12 KB
  Frame 14 - Color Quantization    0.0565s (  5.2%)  +4096.12 KB
  Frame 9 - Color Quantization     0.0563s (  5.2%)  +4096.12 KB
  Frame 13 - Color Quantization    0.0563s (  5.2%)  +4096.12 KB
  Frame 11 - Color Quantization    0.0560s (  5.2%)  +4096.12 KB
  Frame 4 - Color Quantization     0.0559s (  5.1%)  +4096.12 KB
  Frame 1 - LZW Compression        0.0190s (  1.7%)  +633.53 KB
  Frame 7 - LZW Compression        0.0189s (  1.7%)  +633.39 KB
  Frame 3 - LZW Compression        0.0186s (  1.7%)  +628.88 KB
  Frame 11 - LZW Compression       0.0185s (  1.7%)  +634.52 KB
  Frame 6 - LZW Compression        0.0185s (  1.7%)  +632.41 KB
  Frame 8 - LZW Compression        0.0185s (  1.7%)  +634.67 KB
  Frame 12 - LZW Compression       0.0183s (  1.7%)  +633.48 KB
  Frame 13 - LZW Compression       0.0183s (  1.7%)  +632.53 KB
  Frame 14 - LZW Compression       0.0182s (  1.7%)  +632.53 KB
  Frame 9 - LZW Compression        0.0182s (  1.7%)  +633.13 KB
  Frame 5 - LZW Compression        0.0181s (  1.7%)  +631.86 KB
  Frame 4 - LZW Compression        0.0181s (  1.7%)  +630.28 KB
  Frame 10 - LZW Compression       0.0181s (  1.7%)  +633.01 KB
  Frame 2 - LZW Compression        0.0180s (  1.7%)  +629.15 KB
  Final Concatenation              0.0001s (  0.0%)  +63.43 KB
  Palette Generation               0.0000s (  0.0%)  +26.16 KB
==========================================

After using ffi to access pixel data directly (instead of love.ImageData:getPixel()):

GIF Recording started...
Encoding 14 frames...

========== GIF ENCODER PROFILE ==========
Total Time: 1.1261 seconds
Total Memory Delta: 316.01 KB

--- Section Breakdown ---
  Frame 1 - Color Quantization     0.0802s (  7.1%)  +4096.39 KB
  Frame 3 - Color Quantization     0.0606s (  5.4%)  +4096.44 KB
  Frame 5 - Color Quantization     0.0603s (  5.4%)  +4096.53 KB
  Frame 4 - Color Quantization     0.0602s (  5.3%)  +4096.34 KB
  Frame 2 - Color Quantization     0.0599s (  5.3%)  +4096.39 KB
  Frame 12 - Color Quantization    0.0596s (  5.3%)  +4096.34 KB
  Frame 10 - Color Quantization    0.0596s (  5.3%)  +4096.34 KB
  Frame 14 - Color Quantization    0.0596s (  5.3%)  +4096.34 KB
  Frame 6 - Color Quantization     0.0595s (  5.3%)  +4096.34 KB
  Frame 9 - Color Quantization     0.0595s (  5.3%)  +4096.72 KB
  Frame 7 - Color Quantization     0.0594s (  5.3%)  +4096.34 KB
  Frame 13 - Color Quantization    0.0592s (  5.3%)  +4096.34 KB
  Frame 11 - Color Quantization    0.0591s (  5.2%)  +4096.34 KB
  Frame 8 - Color Quantization     0.0589s (  5.2%)  +4096.34 KB
  Frame 9 - LZW Compression        0.0190s (  1.7%)  +624.80 KB
  Frame 1 - LZW Compression        0.0187s (  1.7%)  +623.75 KB
  Frame 6 - LZW Compression        0.0186s (  1.6%)  +623.30 KB
  Frame 13 - LZW Compression       0.0185s (  1.6%)  +623.14 KB
  Frame 10 - LZW Compression       0.0184s (  1.6%)  +624.27 KB
  Frame 12 - LZW Compression       0.0184s (  1.6%)  +625.08 KB
  Frame 5 - LZW Compression        0.0184s (  1.6%)  +622.09 KB
  Frame 2 - LZW Compression        0.0184s (  1.6%)  +619.82 KB
  Frame 8 - LZW Compression        0.0183s (  1.6%)  +624.99 KB
  Frame 4 - LZW Compression        0.0183s (  1.6%)  +621.71 KB
  Frame 7 - LZW Compression        0.0183s (  1.6%)  +622.90 KB
  Frame 11 - LZW Compression       0.0182s (  1.6%)  +625.04 KB
  Frame 14 - LZW Compression       0.0181s (  1.6%)  +623.14 KB
  Frame 3 - LZW Compression        0.0180s (  1.6%)  +619.74 KB
  Final Concatenation              0.0001s (  0.0%)  +62.16 KB
==========================================


