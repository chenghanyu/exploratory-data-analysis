# Coursera Data Science: Exploratory Data Analysis
# Course project 2: plot 6
# Cheng-Han Yu
################################################################################
# Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?

# load and check data
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

# head(NEI)
# head(SCC)

# NEI on-road data for Baltimore City and LA county
NEI_Baltimore_motor  <- NEI[NEI$fips == "24510" & NEI$type == "ON-ROAD", ]
NEI_LA_motor  <- NEI[NEI$fips == "06037" & NEI$type == "ON-ROAD", ]

# aggregated Emission by year and type for Baltimore City and LA county
aggEmission_Baltimore_motor <- aggregate(formula = Emissions ~ year, 
                                         data = NEI_Baltimore_motor, FUN = sum)
aggEmission_LA_motor <- aggregate(formula = Emissions ~ year, 
                                         data = NEI_LA_motor, FUN = sum)
aggEmission_Baltimore_LA_motor <- rbind(aggEmission_Baltimore_motor, 
                                        aggEmission_LA_motor)
aggEmission_Baltimore_LA_motor <- cbind(aggEmission_Baltimore_LA_motor, 
                                        region = c(rep("Bal", 4), rep("LA", 4)))
attach(aggEmission_Baltimore_LA_motor)

# make a barplot
library(ggplot2)
g <- ggplot(aggEmission_Baltimore_LA_motor, aes(factor(year), Emissions))

g <- g + geom_bar(stat = "identity", aes(fill = factor(year))) + 
    xlab("year") + ylab(expression('total PM'[2.5]*" emission")) + 
    ggtitle('Total Emissions from Motor Vehicles Changed from 1999 to 2008\nBaltimore City, MD vs LA county, CA') +
    theme(axis.text.x = element_text(colour = "grey20", size = 12), 
          axis.text.y = element_text(colour = "grey20", size = 14),
          axis.title.x = element_text(size = 18, hjust = .5),
          axis.title.y = element_text(size = 18, hjust = .5, vjust = 1),
          title = element_text(size = 20, hjust = .5)) +
    facet_grid(. ~ region) +
    theme(legend.position = 'none') +
    scale_y_continuous(breaks = c(seq(0, 500, 250), seq(500, 5000, 1000)))
print(g)


# Save file
dev.copy(png, file = "plot6.png", height = 750, width = 1000)
dev.off()
