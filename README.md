# Machine-Learning
Some easy Matlab programs

a3, b3, c3 are all program to do classification
I implement three classiﬁers and run them on the MNIST Handwritten Digits data set posted on Courseworks and the class website. Do not preprocess the data except in the way discussed at the end of the README below. Information about the data is given below.
All three sub-problems ask for you to show your results in a 10 × 10 “confusion matrix” (call it C). This can be done as follows: For each of the 500 predictions you make from the test set, let yt be the true
class label and yp be the predicted class label using your algorithm. Update C(yt, yp) ← C(yt, yp) + 1
for each prediction. At the end, C should sum to 500 and each row should sum to 50. (C can then be normalized, but leave it unnormalized for this assignment.)
