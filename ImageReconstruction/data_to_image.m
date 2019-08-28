function data_to_image(data)



V = zeros(256,256,95);



niftiwrite(V,'outbrain.nii');