# Coursera Data Science: Exploratory Data Analysis
# Course project 2: plot 5
# Cheng-Han Yu
################################################################################
# How have emissions from motor vehicle sources changed from 1999–2008 in 
# Baltimore City?

# load and check data
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

# head(NEI)
# head(SCC)

# NEI on-road data for Baltimore City
NEI_Baltimore_motor  <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]

# aggregated Emission by year and type for Baltimore City
aggEmission_Baltimore_motor <- aggregate(formula = Emissions ~ year, 
                                        data = NEI_Baltimore_motor, FUN = sum)
attach(aggEmission_Baltimore_motor)


# make a barplot
g <- ggplot(aggEmission_Baltimore_motor, aes(factor(year), Emissions))
library(ggplot2)

g <- g + geom_bar(stat = "identity", fill = "lightblue", colour = "darkblue") + 
    xlab("year") + ylab(expression('total PM'[2.5]*" emission")) + 
    ggtitle('Total Emissions from Motor Vehicles Changed from 1999 to 2008 in Baltimore City, MD') +
    theme(axis.text.x = element_text(colour = "grey20", size = 12), 
          axis.text.y = element_text(colour = "grey20", size = 14),
          axis.title.x = element_text(size = 18, hjust = .5),
          axis.title.y = element_text(size = 18, hjust = .5, vjust = 1),
          title = element_text(size = 20, hjust = .5))
print(g)


# Save file
dev.copy(png, file = "plot5.png", height = 750, width = 1000)
dev.off()
