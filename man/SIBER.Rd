\name{SIBER}
\alias{SIBER}
\title{Fit Mixture Model on The RNAseq Data and Calculates Bimodality Index}
\description{
The function fits a two-component mixture model and calculate BI from the parameter estimates. 
}
\usage{
SIBER(y, d=NULL, model=c('LN', 'NB', 'GP', 'NL'), zeroPercentThr=0.2, base=exp(1), eps=10)
}

\arguments{  
\item{y}{A vector representing the RNAseq raw count or the transformed values if model=NL. }
\item{d}{A vector of the same length as y representing the normalization constant to be applied to the data.}
\item{model}{Character string specifying the mixture model type. It can be any of LN, NB, GP and NL.} 
\item{zeroPercentThr}{A scalar specifying the minimum percent of zero to detect using log normal mixture. This
parameter is used to deal with zero-inflation in RNAseq count data. When the percent of zero exceeds this threshold, 
1-comp mixture LN model is used to estimate mu and sigma from nonzero count. This parameter is relevant only if model='LN'.
} 
\item{base}{The logarithm base defining the parameter estimates in the logarithm scale from LN model . It is relevant only if model='LN'.} 
\item{eps}{A scalar to be added to the count data when model='LN'. This parameter is relevant only when model='LN'. } 
}

\details{
SIBER proceeds in two steps. The first step fits a two-component mixture model. 
The second step calculates the Bimodality Index corresponding to the assumed mixture distribution.
Four types of mixture models are implemented: log normal (LN), Negative Binomial (NB),  Generalized Poisson (GP) and normal mixture (NL). The normal mixture model was developed to identify bimodal genes from microarray data in Wang et al. It is incorporated here
in case the user has already transformed the RNAseq data.

Behind the scene, SIBER calls the fitNB, fitGP, fitLN and fitNL function with model=E depending on which
distribution model is specified. When the observed percentage of count exceeds the user specified threshold
zeroPercentThr, the 0-inflated model overrides the E model and will be fitted. 

Type vignette('SIBER') in the R console to pull out the user manual in pdf format. 


}

\value{
A vector consisting estimates of mu1, mu2, sigma1, sigma2, p1, delta and BI. 
}

\references{
  Wang J, Wen S, Symmans WF, Pusztai L, Coombes KR.\cr
  \emph{The bimodality index: a criterion for discovering and ranking
    bimodal signatures from cancer gene expression profiling data.}\cr
  Cancer Inform. 2009 Aug 5;7:199-216.

  Tong P, Chen Y, Su X, Coombes KR.\cr
  \emph{SIBER: systematic identification of bimodally expressed genes
    using RNAseq data.}\cr
  Bioinformatics. 2013 Mar 1;29(5):605-13.
}
\author{
Pan Tong (nickytong@gmail.com), Kevin R Coombes (krc@silicovore.com)
}
\seealso{
\link{fitLN}
\link{fitNB}
\link{fitGP}
\link{fitNL}
}


\examples{
# artificial RNAseq data from negative binomial distribution
set.seed(1000)
dat <- rnbinom(100, mu=1000, size=1/0.2)
# fit SIBER with the 4 mixture models
SIBER(y=dat, model='LN')
SIBER(y=dat, model='NB')
SIBER(y=dat, model='GP')
SIBER(y=log(dat+1), model='NL')

}
