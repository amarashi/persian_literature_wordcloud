shinyUI(fluidPage( 
  titlePanel(h2("ابرِ واژگان", align = "center")), #Title
  sidebarLayout(position = "right",
    sidebarPanel(
      selectInput("author", 
                  "نویسنده",
                  c(
                    "ابوسعید ابوالخیر"="abvsEid-abvalkhir",
                    "جامی"= "jami",
                    "حافظ" = "hafz",
                    "خاقانی" = "khaghani",
                    "خیام"= "khiam",
                    "سعدی"=  "sEdi",
                    "سنایی" = "snaii",
                    "شیخ بهایی"= "shikh-bhaii",
                    "عبید زاکانی" = "Ebid-zakani",
                    "عطار"= "Etar",
                    "فخرالدین اسعد گرگانی"= "fkhraldin-asEd-grgani",
                    "فردوسی" = "frdvsi",
                    "مولوی" = "mvlvi",
                    "نظامی" = "nzami"
                    
                    )),
      hr(),
      sliderInput("freq",
                 "کمترین تکرار واژه",
                  min = 1,  max = 50, value = 15),
      sliderInput("max",
                  "بیشترین تعداد نمایش",
                  min = 1,  max = 400,  value = 150),
      sliderInput("size",
                  "اندازه",
                  min = 0.2,  max = 10,  value = 5)
    
    ),
    mainPanel(
      plotOutput("abrPlot")
      # ,textOutput("debug")
      )
    )
))



