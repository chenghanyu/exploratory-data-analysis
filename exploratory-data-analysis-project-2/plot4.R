# Coursera Data Science: Exploratory Data Analysis
# Course project 2: plot 4
# Cheng-Han Yu
################################################################################
# Across the United States, how have emissions from coal combustion-related 
# sources changed from 1999–2008?

# load and check data
if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

# head(NEI)
# head(SCC)

# merge two data sets
# grepl returns a logical vector (match or not for each element of x)
# Coal combustion related sources
SCC_coal = SCC[grepl(pattern = "coal", x = SCC$Short.Name, 
                     ignore.case = TRUE), ]
NEI_coal <- merge(x = NEI, y = SCC_coal, by = 'SCC')

# aggregated Emission by year and for coal related emission
aggEmission_coal <- aggregate(formula = Emissions ~ year, 
                       data = NEI_coal, FUN = sum)

library(ggplot2)

attach(aggEmission_coal)

# make a barplot
g <- ggplot(aggEmission_coal, aes(factor(year), Emissions))

g <- g + geom_bar(stat = "identity") + 
    xlab("year") + ylab(expression('total PM'[2.5]*" emission")) + 
    ggtitle('Total Emissions from Coal Sources Changed from 1999 to 2008') +
    theme(axis.text.x = element_text(colour = "grey20", size = 12), 
          axis.text.y = element_text(colour = "grey20", size = 14),
          axis.title.x = element_text(size = 18, hjust = .5),
          axis.title.y = element_text(size = 18, hjust = .5, vjust = 1),
          title = element_text(size = 20, hjust = .5)) +
    scale_y_continuous(labels = as.character(seq(0, 600000, 200000)))
print(g)


# Save file
dev.copy(png, file = "plot4.png", height = 650, width = 800)
dev.off()
