library(ggplot2)
# define the link to the data - you can try this in your browser too.  Note that the URL ends in .txt.
dataurl="https://data.giss.nasa.gov/tmp/gistemp/STATIONS/tmp_USW00014733_14_0_1/station.txt"
#the next line tells the NASA site to create the temporary file
httr::GET("https://data.giss.nasa.gov/cgi-bin/gistemp/stdata_show_v4.cgi?id=USW00014733&ds=14&dt=1")
# the next lines download the data
temp=read_table(dataurl,
                skip=3, #skip the first line which has column names
                na="999.90", # tell R that 999.90 means missing in this dataset
                col_names = c("YEAR","JAN","FEB","MAR", # define column names 
                              "APR","MAY","JUN","JUL",  
                              "AUG","SEP","OCT","NOV",  
                              "DEC","DJF","MAM","JJA",  
                              "SON","metANN"))

dat=temp[,7;9]
year=temp[,1]
row_mean=apply(dat,1,mean)
JJA_mean=data.frame(row_mean)
JJA_years=cbind(years,JJA_mean)

library(ggplot2)
ggplot(data = JJA_years,mapping = aes(x=year,y=row_mean,group=1))
+geom_line()
+geom_smooth()
+labs(x="year",y="Mean Summer Temperatures(c°)",
      title = "Mean SUM TEMPERATURES in buffalo",
      sub = "summer includes june,july,and august Data from the Global historical climate nework red line is a LOESS smooth"）
      +theme(axis.text.x = element_text(size = 30),axis.title.y = element_text(size = 30)title = element_text(40))
      ggsave(filename = "Mean summer TEMPeratures in buffalo.png",
             width = 17,
             height = 9,
             units = "in",
             dpi = 300)
      
      