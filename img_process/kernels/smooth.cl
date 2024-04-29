__kernel void edge_smooth(__global const uchar* input_image, __global uchar* output_image, const int width, const int height) {
    int x = get_global_id(0);
    int y = get_global_id(1);
    int idx = y * width + x;
    int channels = 3; 
    
    int r = 0, g = 0, b = 0;
    
    // Calculate the starting index for the current row
    int row_start_idx = y * width * channels;
    
    // Iterate over the neighboring pixels for edge smoothing
    for (int dx = -1; dx <= 1; ++dx) {
        for (int dy = -1; dy <= 1; ++dy) {
            int sx = clamp(x + dx, 0, width - 1);
            int sy = clamp(y + dy, 0, height - 1);
            
            // Calculate the index for the current pixel in the flattened array
            int sidx = row_start_idx + sx * channels;
            
            r += input_image[sidx];
            g += input_image[sidx + 1];
            b += input_image[sidx + 2];
        }
    }
    
    // Compute the average color
    r /= 9;
    g /= 9;
    b /= 9;
    
    // Write the result to the output image
    output_image[idx * channels] = r;
    output_image[idx * channels + 1] = g;
    output_image[idx * channels + 2] = b;
}
