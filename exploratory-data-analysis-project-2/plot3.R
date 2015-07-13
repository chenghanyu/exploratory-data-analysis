# Coursera Data Science: Exploratory Data Analysis
# Course project 2: plot 3
# Cheng-Han Yu
################################################################################
# Of the four types of sources indicated by the type 
# (point, nonpoint, onroad, nonroad) variable, which of these four sources 
# have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? Use the ggplot2 
# plotting system to make a plot answer this question.

# load and check data
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}
# head(NEI)
# head(SCC)

attach(NEI)
library(ggplot2)

# NEI data for Baltimore City
NEI_Baltimore  <- NEI[NEI$fips == "24510", ]

# aggregated Emission by year and type for Baltimore City
aggEmission_Baltimore_type <- aggregate(formula = Emissions ~ year + type, 
                                   data = NEI_Baltimore, FUN = sum)
attach(aggEmission_Baltimore_type)
year = as.character(year)
type = as.factor(type)

# make a barplot
g <- ggplot(aggEmission_Baltimore_type, aes(factor(year), Emissions))

g <- g + geom_bar(aes(fill = type), stat = "identity") + facet_grid(. ~ type) + 
    xlab("year") + ylab(expression('total PM'[2.5]*" emission")) + 
    ggtitle('Total Emissions in Baltimore City from 1999 to 2008') +
    theme(axis.text.x = element_text(colour = "grey20", size = 12), 
          axis.text.y = element_text(colour = "grey20", size = 14),
          axis.title.x = element_text(size = 18, hjust = .5),
          axis.title.y = element_text(size = 18, hjust = .5, vjust = 1),
          title = element_text(size = 20, hjust = .5)) + 
    coord_cartesian(ylim = c(0, max(Emissions) + 100)) +
    scale_y_continuous(breaks = seq(0, 2500, 250))

print(g)




# Save file
dev.copy(png, file = "plot3.png", height = 650, width = 800)
dev.off()
