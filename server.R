library(shiny) 
library(e1071)
library(lattice)
library(ggplot2)
library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
set.seed(125)
library(rpart)
#split the dataset into training and testing sets
intrain=createDataPartition(segmentationOriginal$Case,list=FALSE)
training=subset(segmentationOriginal,Case=="Train")
testing=subset(segmentationOriginal,Case=="Test")
modelFit=train(Class~.,method="rpart",data=training)
library(rattle)
library(rpart.plot)

diagnostic_f=function(TotalIntenCh2,FiberWidthCh1){
  ifelse(TotalIntenCh2<45000,"Poorly Segmented",ifelse(FiberWidthCh1<9.7,"Poorly Segmented","Well Segmented"))
}
shinyServer(
  function(input, output) {
    
    output$inputTotalIntenCh2value=renderPrint({input$TotalIntenCh2})
    output$inputFiberWidthCh1value=renderPrint({input$FiberWidthCh1})
    output$diagnostic= renderPrint({diagnostic_f(input$TotalIntenCh2,input$FiberWidthCh1)})
    output$plot1=renderPlot({
     fancyRpartPlot(modelFit$finalModel)
    })
  } 
)