% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/spsNewtab.R
\name{makePlotData}
\alias{makePlotData}
\title{Create data receiving methods for plot tabs}
\usage{
makePlotData(
  dataset_id = "data",
  dataset_label = "Raw data",
  receive_datatab_ids = "data_example",
  vd_expr = spsValidate({     if (is.data.frame(mydata$data))          TRUE     else
    stop("Data xx needs to be a dataframe or tibble") }),
  app_path = getwd(),
  use_string = FALSE
)
}
\arguments{
\item{dataset_id}{string, length 1, a unique ID within this plot
tab.}

\item{dataset_label}{string, length 1, what label to display on UI for this
type of input data}

\item{receive_datatab_ids}{a vector of tab IDs: for this kind of data input,
which data tabs that can be used as input source(s). For example, if this
plot tab requires a dataframe and can be produced from "data_df1" or
"data_df2", \emph{receive_datatab_ids = c("data_df1", "data_df2")}. These options
are later rendered as a drop down menu for users to choose where
they have prepared the required data from.}

\item{vd_expr}{what expression to validate(check) the incoming data set.
Usually it is a \link{spsValidate} object}

\item{app_path}{path, SPS project folder}

\item{use_string}{bool, if you don't want to parse \emph{vd_expr}, use quoted
string for \emph{vd_expr} and turn this to TRUE. See the same argument in
\link{newTabPlot}}
}
\value{
a special list that stores one type of data input info
}
\description{
This function specify for each input data type in a plot tab,
\enumerate{
\item where the data is coming from, 2. how to validate incoming data.
To use this function, make sure there is a SPS project and
\emph{config/tabs.csv} exists.
}
}
\details{
For the validation expression, the incoming data is stored in a
reactive values object, and you can access this data object
by \emph{mydata$dataset_id},
e.g. the dataset_id is "raw_data", then when the time you validate this
type of incoming data set, a variable \emph{mydata$raw_data} is accessible. So you
can directly use \code{mydata$raw_data} in \emph{vd_expr}.

It is recommended to create data tabs first before running this function,
because \emph{receive_datatab_ids} required data tab id exists in the \emph{tabs.csv}
file.
}
\examples{
spsInit(change_wd = FALSE, overwrite = TRUE, project_name = "SPS_plotdata")
newTabData("data_df1", "df 1",
           app_path = "SPS_plotdata",
           open_file = FALSE)
newTabData("data_df2", "df 2",
           app_path = "SPS_plotdata",
           open_file = FALSE)
plotdata_raw <- makePlotData("raw", "raw data",
             receive_datatab_ids = "data_df1",
             vd_expr = spsValidate({
                 if(!is.data.frame(mydata$raw))
                     stop("Input raw data need to be a dataframe")
             }, vd_name = "Validate raw data"),
             app_path = "SPS_plotdata")
plotdata_meta <- makePlotData("meta", "meta data",
             receive_datatab_ids = c("data_df1", "data_df2"),
             vd_expr = spsValidate({
                 if(!is.data.frame(mydata$meta))
                     stop("Input raw data need to be a dataframe")
                 if(nrow(mydata$meta) < 1)
                     stop("Input raw data need to have at least one row")
             }, vd_name = "Validate meta data"),
             app_path = "SPS_plotdata")
newTabPlot("plot_test1",
           app_path = "SPS_plotdata",
           plot_data = list(plotdata_raw, plotdata_meta))
}
\seealso{
\link{newTabPlot}
}
