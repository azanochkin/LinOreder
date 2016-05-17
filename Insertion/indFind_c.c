#include "mex.h"

void indFind(bool *maskVec, size_t n, int *m, int *ind)
{
  size_t i = 0;
  int cntr = 0;
  while ((cntr < m[0]) && (i < n)){
    if (maskVec[i])
      cntr++;
    i++;
  }
  if (cntr < m[0])
    ind[0] = 0;
  else
    ind[0] = i;
}

void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
  bool *maskVec;
  int *ind,*m;
  size_t n;
  
  if(nrhs!=2) 
    mexErrMsgIdAndTxt( "MATLAB:indFind:invalidNumInputs",
            "Two inputs required.");
  if(nlhs!=1) 
    mexErrMsgIdAndTxt( "MATLAB:indFind:invalidNumOutputs",
            "One output required.");

  if( !mxIsClass(prhs[0],"logical") || 
      ((mxGetN(prhs[0])>1) && (mxGetM(prhs[0])>1))) {
    mexErrMsgIdAndTxt( "MATLAB:indFind:maskNotLogicalVec",
            "Input mask must be a logical vector.");
  }
      
  if( !mxIsClass(prhs[1],"int32") || mxIsComplex(prhs[1]) ||
      mxGetN(prhs[1])*mxGetM(prhs[1])!=1 ) {
    mexErrMsgIdAndTxt( "MATLAB:indFind:posNotScalar",
            "Input pos must be a scalar.");
  }
  
  maskVec = (bool *)mxGetData(prhs[0]);
  m = (int *)mxGetData(prhs[1]);
  
  n = mxGetN(prhs[0]);
  if (n == 1)
    n = mxGetM(prhs[0]);
  
  plhs[0] = mxCreateNumericMatrix(1, 1, mxINT32_CLASS, mxREAL);
  ind = (int *)mxGetData(plhs[0]);
  
  indFind(maskVec,n,m,ind);
  
}