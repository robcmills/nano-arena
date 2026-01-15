 


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

After passing in palette to encoder: (color quantization via hash table)

GIF Recording started...
Encoding 14 frames...

========== GIF ENCODER PROFILE ==========
Total Time: 0.6237 seconds
Total Memory Delta: 318.76 KB

--- Section Breakdown ---
  Frame 1 - Color Quantization     0.0435s (  7.0%)  +4096.39 KB
  Frame 2 - Color Quantization     0.0284s (  4.6%)  +4096.39 KB
  Frame 6 - Color Quantization     0.0263s (  4.2%)  +4096.34 KB
  Frame 7 - Color Quantization     0.0263s (  4.2%)  +4096.34 KB
  Frame 3 - Color Quantization     0.0262s (  4.2%)  +4096.44 KB
  Frame 13 - Color Quantization    0.0262s (  4.2%)  +4096.34 KB
  Frame 9 - Color Quantization     0.0262s (  4.2%)  +4096.72 KB
  Frame 5 - Color Quantization     0.0260s (  4.2%)  +4096.53 KB
  Frame 14 - Color Quantization    0.0260s (  4.2%)  +4096.34 KB
  Frame 4 - Color Quantization     0.0260s (  4.2%)  +4096.34 KB
  Frame 8 - Color Quantization     0.0260s (  4.2%)  +4096.34 KB
  Frame 11 - Color Quantization    0.0259s (  4.2%)  +4096.34 KB
  Frame 12 - Color Quantization    0.0259s (  4.2%)  +4096.34 KB
  Frame 10 - Color Quantization    0.0259s (  4.1%)  +4096.34 KB
  Frame 1 - LZW Compression        0.0198s (  3.2%)  +624.32 KB
  Frame 2 - LZW Compression        0.0164s (  2.6%)  +619.82 KB
  Frame 9 - LZW Compression        0.0161s (  2.6%)  +623.50 KB
  Frame 8 - LZW Compression        0.0160s (  2.6%)  +623.50 KB
  Frame 12 - LZW Compression       0.0159s (  2.6%)  +625.08 KB
  Frame 13 - LZW Compression       0.0159s (  2.5%)  +623.14 KB
  Frame 14 - LZW Compression       0.0158s (  2.5%)  +623.14 KB
  Frame 11 - LZW Compression       0.0158s (  2.5%)  +625.04 KB
  Frame 6 - LZW Compression        0.0158s (  2.5%)  +623.30 KB
  Frame 3 - LZW Compression        0.0158s (  2.5%)  +619.74 KB
  Frame 10 - LZW Compression       0.0158s (  2.5%)  +624.27 KB
  Frame 5 - LZW Compression        0.0158s (  2.5%)  +622.09 KB
  Frame 7 - LZW Compression        0.0157s (  2.5%)  +622.90 KB
  Frame 4 - LZW Compression        0.0157s (  2.5%)  +621.71 KB
  Final Concatenation              0.0001s (  0.0%)  +62.13 KB
==========================================


Somehow the same test is now producing more frames ??

========== GIF ENCODER PROFILE ==========
Total Time: 1.0391 seconds
Total Memory Delta: 632.66 KB

--- Section Breakdown ---
  Frame 1 - Color Quantization     0.0370s (  3.6%)  +4096.39 KB
  Frame 2 - Color Quantization     0.0262s (  2.5%)  +4096.39 KB
  Frame 7 - Color Quantization     0.0260s (  2.5%)  +4096.34 KB
  Frame 11 - Color Quantization    0.0259s (  2.5%)  +4096.34 KB
  Frame 23 - Color Quantization    0.0258s (  2.5%)  +4096.34 KB
  Frame 18 - Color Quantization    0.0257s (  2.5%)  +4096.34 KB
  Frame 10 - Color Quantization    0.0257s (  2.5%)  +4096.34 KB
  Frame 20 - Color Quantization    0.0255s (  2.5%)  +4096.34 KB
  Frame 12 - Color Quantization    0.0255s (  2.5%)  +4096.34 KB
  Frame 22 - Color Quantization    0.0254s (  2.4%)  +4096.34 KB
  Frame 8 - Color Quantization     0.0253s (  2.4%)  +4096.34 KB
  Frame 21 - Color Quantization    0.0252s (  2.4%)  +4096.34 KB
  Frame 5 - Color Quantization     0.0252s (  2.4%)  +4096.53 KB
  Frame 9 - Color Quantization     0.0252s (  2.4%)  +4096.72 KB
  Frame 13 - Color Quantization    0.0252s (  2.4%)  +4096.34 KB
  Frame 15 - Color Quantization    0.0251s (  2.4%)  +4096.34 KB
  Frame 6 - Color Quantization     0.0251s (  2.4%)  +4096.34 KB
  Frame 14 - Color Quantization    0.0251s (  2.4%)  +4096.34 KB
  Frame 16 - Color Quantization    0.0251s (  2.4%)  +4096.34 KB
  Frame 19 - Color Quantization    0.0250s (  2.4%)  +4096.34 KB
  Frame 24 - Color Quantization    0.0250s (  2.4%)  +4096.34 KB
  Frame 17 - Color Quantization    0.0250s (  2.4%)  +4097.09 KB
  Frame 4 - Color Quantization     0.0249s (  2.4%)  +4096.34 KB
  Frame 3 - Color Quantization     0.0245s (  2.4%)  +4096.44 KB
  Frame 1 - LZW Compression        0.0196s (  1.9%)  +624.88 KB
  Frame 10 - LZW Compression       0.0169s (  1.6%)  +624.67 KB
  Frame 19 - LZW Compression       0.0168s (  1.6%)  +626.39 KB
  Frame 13 - LZW Compression       0.0167s (  1.6%)  +625.83 KB
  Frame 2 - LZW Compression        0.0167s (  1.6%)  +620.41 KB
  Frame 7 - LZW Compression        0.0166s (  1.6%)  +623.74 KB
  Frame 14 - LZW Compression       0.0166s (  1.6%)  +625.52 KB
  Frame 17 - LZW Compression       0.0166s (  1.6%)  +625.48 KB
  Frame 20 - LZW Compression       0.0165s (  1.6%)  +626.17 KB
  Frame 15 - LZW Compression       0.0165s (  1.6%)  +625.52 KB
  Frame 3 - LZW Compression        0.0165s (  1.6%)  +621.20 KB
  Frame 16 - LZW Compression       0.0165s (  1.6%)  +626.57 KB
  Frame 22 - LZW Compression       0.0164s (  1.6%)  +625.79 KB
  Frame 12 - LZW Compression       0.0164s (  1.6%)  +625.16 KB
  Frame 24 - LZW Compression       0.0164s (  1.6%)  +625.57 KB
  Frame 9 - LZW Compression        0.0164s (  1.6%)  +624.67 KB
  Frame 5 - LZW Compression        0.0164s (  1.6%)  +621.96 KB
  Frame 11 - LZW Compression       0.0164s (  1.6%)  +625.16 KB
  Frame 4 - LZW Compression        0.0163s (  1.6%)  +621.20 KB
  Frame 18 - LZW Compression       0.0163s (  1.6%)  +626.07 KB
  Frame 23 - LZW Compression       0.0162s (  1.6%)  +625.57 KB
  Frame 8 - LZW Compression        0.0162s (  1.6%)  +623.98 KB
  Frame 6 - LZW Compression        0.0160s (  1.5%)  +622.17 KB
  Frame 21 - LZW Compression       0.0160s (  1.5%)  +626.17 KB
  Final Concatenation              0.0002s (  0.0%)  +115.82 KB
==========================================

After refactoring gif encoder to encode each frame immediately,
we now get less frames:
I'm starting to see what is happening. We are fucking with how long each frame takes,
in this case, the encoding is taking longer than 16ms (60fps),
thus causing framerate to drop, and the engine is skipping frames to catch up.

GIF Recording started...
Encoding 8 frames...

========== GIF ENCODER PROFILE ==========
Total Time: 0.5470 seconds
Total Memory Delta: 480.72 KB

--- Section Breakdown ---
  Frame 1 - Color Quantization     0.0276s (  5.0%)  +4096.39 KB
  Frame 5 - Color Quantization     0.0272s (  5.0%)  +4096.53 KB
  Frame 2 - Color Quantization     0.0265s (  4.8%)  +4096.39 KB
  Frame 3 - Color Quantization     0.0258s (  4.7%)  +4096.44 KB
  Frame 6 - Color Quantization     0.0257s (  4.7%)  +4096.34 KB
  Frame 7 - Color Quantization     0.0254s (  4.6%)  +4096.34 KB
  Frame 4 - Color Quantization     0.0253s (  4.6%)  +4096.34 KB
  Frame 8 - Color Quantization     0.0251s (  4.6%)  +4096.34 KB
  Frame 2 - LZW Compression        0.0168s (  3.1%)  +626.39 KB
  Frame 1 - LZW Compression        0.0168s (  3.1%)  +625.64 KB
  Frame 5 - LZW Compression        0.0165s (  3.0%)  +631.50 KB
  Frame 8 - LZW Compression        0.0164s (  3.0%)  +631.56 KB
  Frame 6 - LZW Compression        0.0163s (  3.0%)  +632.16 KB
  Frame 3 - LZW Compression        0.0162s (  3.0%)  +627.19 KB
  Frame 4 - LZW Compression        0.0162s (  3.0%)  +629.97 KB
  Frame 7 - LZW Compression        0.0158s (  2.9%)  +631.56 KB
  Final Concatenation              0.0001s (  0.0%)  +49.83 KB
==========================================

Saved to: /Users/robcmills/Library/Application Support/LOVE/nano-arena/test2.gif

But this change was prep to parallelize gif encoding with threads.
I def don't intend to encode every frame in the main thread.

After moving frame quantization and encoding into a separate thread:

GIF Recording started...
FRAME: 1 NOW: 0.057 DT: 0.057
FRAME: 2 NOW: 0.070 DT: 0.013
FRAME: 3 NOW: 0.078 DT: 0.008
FRAME: 4 NOW: 0.084 DT: 0.006
FRAME: 5 NOW: 0.093 DT: 0.008
FRAME: 6 NOW: 0.101 DT: 0.008
FRAME: 7 NOW: 0.110 DT: 0.009
FRAME: 8 NOW: 0.118 DT: 0.008
FRAME: 9 NOW: 0.131 DT: 0.013
FRAME: 10 NOW: 0.147 DT: 0.016
FRAME: 11 NOW: 0.151 DT: 0.003
FRAME: 12 NOW: 0.159 DT: 0.008
FRAME: 13 NOW: 0.167 DT: 0.008
FRAME: 14 NOW: 0.175 DT: 0.007
FRAME: 15 NOW: 0.184 DT: 0.009
FRAME: 16 NOW: 0.192 DT: 0.008
FRAME: 17 NOW: 0.201 DT: 0.009
FRAME: 18 NOW: 0.208 DT: 0.007
FRAME: 19 NOW: 0.217 DT: 0.009
FRAME: 20 NOW: 0.226 DT: 0.009
FRAME: 21 NOW: 0.234 DT: 0.008
FRAME: 22 NOW: 0.242 DT: 0.008
FRAME: 23 NOW: 0.251 DT: 0.009
FRAME: 24 NOW: 0.259 DT: 0.008
Waiting for 23 frames to finish encoding...
Encoding 23 frames into GIF...
Saved to: /Users/robcmills/Library/Application Support/LOVE/nano-arena/test2.gif

========== GIF ENCODER PROFILE ==========
Total Time: 0.8888 seconds
Total Memory Delta: 2770.09 KB

--- Section Breakdown ---
  Wait for thread to finish        0.8810s ( 99.1%)  +2214.70 KB
  Encoding gif                     0.0053s (  0.6%)  +647.91 KB
==========================================


And without recording a gif:

FRAME: 1 NOW: 0.064 DT: 0.064
FRAME: 2 NOW: 0.073 DT: 0.009
FRAME: 3 NOW: 0.084 DT: 0.011
FRAME: 4 NOW: 0.087 DT: 0.003
FRAME: 5 NOW: 0.094 DT: 0.007
FRAME: 6 NOW: 0.103 DT: 0.009
FRAME: 7 NOW: 0.112 DT: 0.009
FRAME: 8 NOW: 0.120 DT: 0.008
FRAME: 9 NOW: 0.133 DT: 0.013
FRAME: 10 NOW: 0.136 DT: 0.003
FRAME: 11 NOW: 0.144 DT: 0.008
FRAME: 12 NOW: 0.157 DT: 0.013
FRAME: 13 NOW: 0.160 DT: 0.003
FRAME: 14 NOW: 0.169 DT: 0.008
FRAME: 15 NOW: 0.177 DT: 0.008
FRAME: 16 NOW: 0.186 DT: 0.009
FRAME: 17 NOW: 0.194 DT: 0.008
FRAME: 18 NOW: 0.202 DT: 0.008
FRAME: 19 NOW: 0.211 DT: 0.009
FRAME: 20 NOW: 0.218 DT: 0.008
FRAME: 21 NOW: 0.227 DT: 0.009
FRAME: 22 NOW: 0.235 DT: 0.008
FRAME: 23 NOW: 0.243 DT: 0.008
FRAME: 24 NOW: 0.252 DT: 0.009
FRAME: 25 NOW: 0.260 DT: 0.008
FRAME: 26 NOW: 0.268 DT: 0.009

So it looks like moving the gif encoding of each frame into a thread has successfully not affected framerate.

Just that first frame is slow... Why?
