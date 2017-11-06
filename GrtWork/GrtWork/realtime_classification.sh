

### run python script to convert txt file to grt ###

# cd into trainingData
cd ~/Github/GrtWork/TrainingData

# run python script to convert test files into .grt's

# nat throw test data
python time_series_convert_certain_joints.py /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/TestRealtime/a* > classify_with_cole.grt


# cd into GrtWork
cd ../GrtWork

# compile classification program
g++ -std=c++11 -I ../../grt/GRT DTWClassify.cpp libgrt.a  -o DTWClassify

# run classification program with pretrained model
./DTWClassify

