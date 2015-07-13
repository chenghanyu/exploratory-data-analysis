# Coursera Data Science: Exploratory Data Analysis
# Course project 2: plot 1
# Cheng-Han Yu
################################################################################
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

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
# aggregated Emission by year
aggEmission <- aggregate(formula = Emissions ~ year, data = NEI, FUN = sum)

# make a barplot
barplot(height = aggEmission$Emissions, names.arg = aggEmission$year,
        xlab = "year", ylab = expression('total PM'[2.5]* ' emission'),
        main = expression('Total PM'[2.5]* ' emission of year 1999, 2002, 2005, and 2008'),
        col = "gold")


# Save file
dev.copy(png, file = "plot1.png", height = 650, width = 650)
dev.off()



