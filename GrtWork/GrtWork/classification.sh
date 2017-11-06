

### run python script to convert txt file to grt ###

# cd into trainingData
cd ../TrainingData

# run python script to convert test files into .grt's

# nat throw test data
#python time_series_convert_certain_joints.py /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/TestNatThrowPositions/a05* > classify_with_cole.grt

# nat kick test data
# python time_series_convert_certain_joints.py /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/TestNatKickPositions/a09* > classify_with_cole.grt

# nat throw test data with velocities
# python time_series_convert_certain_joints.py /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/TestNatThrowPositionsAndVelocities/a05* > classify_with_cole.grt

# nat kick test data with velocities
# python time_series_convert_certain_joints.py /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/TestNatKickPositionsAndVelocities/a09* > classify_with_cole.grt

# nat stand still test data
# python time_series_convert_certain_joints.py /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/TestNatStandStillPositions/a20* > classify_with_cole.grt

# adrian test kick
python time_series_convert_certain_joints.py /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/TestCole/a* > classify_with_cole.grt


# run python script to convert dataset files into .grt's

# website data set, kick and throw
# python time_series_convert_certain_joints.py  /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/WebsiteKick/a09* /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/WebsiteThrow/a05* > gestures_with_cole.grt

#cole data, kick and throw
# python time_series_convert_certain_joints.py  /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/ColeKick/a17* /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/ColeThrow/a05* > gestures_with_cole.grt

# nat data, kick and throw
#python time_series_convert_certain_joints.py  /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/NatThrowPositions/a05* /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/NatKickPositions/a09* > gestures_with_cole.grt

# nat data, kick and throw with velocities
# python time_series_convert_certain_joints.py  /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/NatThrowPositionsAndVelocities/a05* /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/NatKickPositionsAndVelocities/a09* > gestures_with_cole.grt

# adrian date, kick and punch positions
python time_series_convert_certain_joints.py  /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/ColeKickPositions2Seconds/a* /Users/colebrossart/Kinect/spark-master/kinect/NITE-Bin-Dev-MacOSX-v1.5.2.21/Samples/Bin/x64-Release/ColePunchPositions2Seconds/a* > gestures_with_cole.grt

# cd into GrtWork
cd ../GrtWork

# create model
g++ -std=c++11 -I ../../grt/GRT DTWExample.cpp libgrt.a  -o DTWExample

# run
./DTWExample

# compile classification program
g++ -std=c++11 -I ../../grt/GRT DTWClassify.cpp libgrt.a  -o DTWClassify

# run classification program with pretrained model
./DTWClassify
