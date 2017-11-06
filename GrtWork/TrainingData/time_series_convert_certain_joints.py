#!/usr/bin/python


from __future__ import print_function
from os.path import basename
import re
import sys

def usage():
    print("Usage:", sys.argv[0], "file1, file2, ...", file=sys.stderr)
    exit()

# from the net
def group(lst, n):
    """group([0,3,4,10,2,3], 2) => [(0,3), (4,10), (2,3)]

    Group a list into consecutive n-tuples. Incomplete tuples are
    discarded e.g.

    >>> group(range(10), 3)
    [(0, 1, 2), (3, 4, 5), (6, 7, 8)]
    """
    return zip(*[lst[i::n] for i in range(n)])


if len(sys.argv) < 2:
    usage()

#outputfile="file_works.grt"
outputfile="stdout"

# read each file. store them in a dictionary
# the keys will be the action ids, the values will be the sample lists

samples_dict = {}

for filename in sys.argv[1:]:
    basenm = basename(filename)
    print("input file: ", basenm, file=sys.stderr)


    # pick the action, subject, experiment ids from the filename
    regexp="a(\d*)_s(\d*)_e(\d*)"
    p = re.compile(regexp)
    m = p.match(basenm)
    if m is None:
        print("files need to be of proper form: aN_sM_eW_realworld.txt", file=sys.stderr)
        usage()
    action = int(m.group(1))
    subject = int(m.group(2))
    experiment = int(m.group(3))

    # read the samples.  15 consecutive rows correspond to the position of each of 15 joints
    samples = []
    with open(filename) as fp:
        for line in fp:
            sample = line.split()
            samples.append(sample)

    print("found {} samples, of dimension {}".format(len(samples), len(samples[0])), file=sys.stderr)

    # group the samples for each of 15 joints, one per line [[a,b,c], [d,e,f], ...]
    # so we have a list, each item in the list is a list of tuples, one per joint
    samples = group(samples,15)
    num_samples = len(samples)
    dims = len(samples[0])

    # before we use it, we can remove/keep the joints we want, then we will flatten the results
    # select some set of joints
    # joints: head=1 (0)
    # right_elbow=4 (3)
    # right_hand=5 (4)
    # left_hand=8 (7)
    # right_knee = 11 (10)
    # right_foot=12 (11)
    # left_foot=15 (14)
    # hand vel (15)
    # foot vel (16)
    samples = map(lambda x: [x[4], x[11]], samples)
    num_samples = len(samples)
    dims = len(samples[0])

    # flatten tuples in each row into one tuple per row
    flatten = lambda l: [item for tuple in l for item in tuple] # also from the net
    samples = map(flatten, samples)
    num_samples = len(samples)
    dims = len(samples[0])

    print("after rearranging, num samples:", num_samples, "dimension:", dims, file=sys.stderr)

    # append the samples to the correct dictionary entry
    if action not in samples_dict:
        samples_dict[action] = []
    samples_dict[action].append(samples)

# create the file

# training example total is the sum of all training sets
training_example_total = 0
for action in samples_dict:
    training_example_total += len(samples_dict[action])

header_1= "GRT_LABELLED_TIME_SERIES_CLASSIFICATION_DATA_FILE_V1.0\n\
DatasetName: KickTimeSeriesData\n\
InfoText: This dataset contains timeseries gestures.\n\
NumDimensions: {dims}\n\
TotalNumTrainingExamples: {num_examples}\n\
NumberOfClasses: {num_classes}\n\
ClassIDsAndCounters:\n".format(dims=dims, num_examples=training_example_total, num_classes=len(samples_dict))

header_2="UseExternalRanges: 0\n\
LabelledTimeSeriesTrainingData:\n"

section_header= "************TIME_SERIES************\n\
ClassID: {action}\n\
TimeSeriesLength: {num_samples}\n\
TimeSeriesData:\n"

print("writing output to:", outputfile, file=sys.stderr)

if outputfile == "stdout":
    fh = sys.stdout
else:
    fh = open(outputfile, "w")

with fh as outfp:
    outfp.write(header_1)
    for action in samples_dict:
        outfp.write("{action}\t{num_examples}\n".format(action=action, num_examples=len(samples_dict[action])))
    outfp.write(header_2)

    # this will be per-input-file
    for action in samples_dict:
        for samples in samples_dict[action]:
            outfp.write(section_header.format(action=action, num_samples=len(samples)))
            for sample in samples:
                outfp.write( "\t".join(sample)+"\n" )
