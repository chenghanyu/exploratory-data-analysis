# Coursera Data Science: Exploratory Data Analysis
# Course project 2: plot 2
# Cheng-Han Yu
################################################################################
# Have total emissions from PM2.5 decreased in the Baltimore City, 
# Maryland (fips == "24510") from 1999 to 2008? 
# Use the base plotting system to make a plot answering this question.

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

# NEI data for Baltimore City
NEI_Baltimore  <- NEI[NEI$fips == "24510", ]

# aggregated Emission by year for Baltimore City
aggEmission_Baltimore <- aggregate(formula = Emissions ~ year, 
                                   data = NEI_Baltimore, FUN = sum)

# make a barplot
barplot(height = aggEmission_Baltimore$Emissions, 
        names.arg = aggEmission_Baltimore$year,
        xlab = "year", ylab = expression('total PM'[2.5]* ' emission'),
        main = expression('Total PM'[2.5]* ' emission in Baltimore City, MD'),
        col = "gold")


# Save file
dev.copy(png, file = "plot2.png", height = 650, width = 650)
dev.off()
