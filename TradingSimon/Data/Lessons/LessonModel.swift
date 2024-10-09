import Foundation

struct LessonModel {
    var iconId: String
    var name: String
    var type: String
    var date: String
    var duration: String
    var isPremium: Bool
    var lessonContent: [LessonContentItem]
}

struct LessonContentItem {
    var title: String
    var content: String
    var isFirstPreview: Bool = false
}

var lessons = [
    LessonModel(iconId: "lesson_premium_icon", name: "Investing in metals", type: "All tools", date: "PREMIUM", duration: "25 min", isPremium: true, lessonContent: [
        LessonContentItem(title: "Investing in metals", content: """
Investing in metals is one of the ways to save and increase your capital. Metals such as gold, silver, platinum and palladium are used in industry, medicine, electronics and other industries, which makes them in demand on the market. You can invest in metals through the purchase of bullion, coins, shares of companies engaged in the extraction and processing of metals, as well as through exchange-traded funds.

However, investing in metals involves certain risks, such as price fluctuations, changes in legislation, political events and market risks. Therefore, before making an investment decision, it is necessary to carefully study the market, choose the appropriate tool and assess the risks.

In this course, we will look at the basics of investing in metals, the risks and profitability of this type of investment, as well as the main investment strategies. We will get acquainted with various investment tools, such as buying bullion, coins or shares, and discuss the advantages and disadvantages of each of them. We will also study the factors affecting metal prices and learn how to analyze the market to make informed investment decisions.
""", isFirstPreview: true),
        LessonContentItem(title: "Introduction to Investing in Metals", content: """
Investing in precious metals is a way to save and increase your capital.
Metals are used in industry, medicine, electronics and other industries, which makes them in demand on the market.
Gold, silver, platinum and palladium are the most popular metals to invest in.
Metal prices can fluctuate depending on supply and demand, the economic situation in the world and other factors.
You can invest in metals through the purchase of bullion, coins, shares of companies engaged in the extraction and processing of metals, as well as through exchange-traded funds.
Before investing in metals, it is necessary to study the market, choose the appropriate instrument and assess the risks.
Investing in metals takes time and effort, but can bring good returns in the long run.
It is important to remember that investing is always associated with the risk of capital loss.
For successful investment, it is necessary to have a clear understanding of how the metal market works and what factors influence its dynamics.
Learning the basics of investing in metals will help you make an informed decision about whether to invest money in this type of asset.
""", isFirstPreview: false),
        LessonContentItem(title: "Risks and profitability of\ninvesting in metals", content: """
Investing in precious metals can be an attractive way to preserve and increase capital, but it also comes with certain risks.
The main risks include fluctuations in metal prices, changes in legislation, political events, as well as market risks associated with market volatility.
The profitability of investments in metals depends on many factors, including supply and demand, the economic situation in the country and the world, geopolitical events and other factors.
In the short term, metal prices can fluctuate greatly, which can lead to losses for investors.
However, in the long term, metals usually show stable growth, which allows investors to make good profits.
To reduce risks, it is recommended to diversify your portfolio by investing in different metals or using different instruments.
You can also use strategies based on fundamental market analysis to identify the most promising areas for investment.
It is important to understand that even with the right approach to investing in metals, it is impossible to completely avoid risks.
Therefore, before making an investment decision, it is necessary to carefully study the market, choose the appropriate tool and assess the risks.
At the same time, it is worth remembering that investing is always associated with the risk of capital loss, and it is important to approach this process consciously and responsibly.
""", isFirstPreview: false),
        LessonContentItem(title: "Strategies for investing\nin metals", content: """
There are several strategies for investing in metals that can be used depending on the goals and preferences of the investor.
The main strategies include: buying bullion, coins or jewelry; investing in shares of companies engaged in the extraction and processing of metals; using exchange-traded funds investing in metals.
Each of these strategies has its advantages and disadvantages, which must be taken into account when choosing.
Buying bullion and coins can be a good way to save capital and profit from rising metal prices. However, this requires significant initial investments and is associated with the need to store and insure assets.
Investments in shares of companies related to metals allow you to receive dividends and participate in the growth of the value of shares. However, this method is also associated with risks such as fluctuations in stock prices and changes in legislation.
Using exchange-traded funds allows you to invest in a wide range of metals without having to choose assets yourself. This can be a convenient way to diversify your portfolio and reduce risks.
When choosing a strategy, it is important to take into account the investment goals, the level of risk that you are willing to accept, and your willingness to study the market and analyze assets.
It is also worth paying attention to the commissions and costs associated with each strategy in order to determine the most profitable option.
For successful investment, it is necessary to have a clear understanding of how the metal market works and what factors influence its dynamics.
Learning the basics of investing in metals will help you make an informed decision about whether to invest money in this type of asset.
""", isFirstPreview: false),
    ]),
    LessonModel(iconId: "lesson_free_1_icon", name: "Choose bonds", type: "Bands", date: "Sep 22, 2024", duration: "5 min", isPremium: false, lessonContent: [
            LessonContentItem(title: "How to choose bonds\nfrom the state", content: """
Investing in bonds can be an effective way to preserve and increase capital. However, like any other type of investment, it comes with certain risks. In order to minimize risks and maximize the benefits of investing in government bonds, it is necessary to carefully study the market and choose the most suitable securities.
""", isFirstPreview: true),
            LessonContentItem(title: "Examine the issuer's reliability", content: """
Investing in bonds can be an effective way to preserve and increase capital. However, like any other type of investment, it comes with certain risks. In order to minimize risks and maximize the benefits of investing in government bonds, it is necessary to carefully study the market and choose the most suitable securities.s
""", isFirstPreview: false),
            LessonContentItem(title: "Determine the\nmaturity date", content: """
Decide for how long you are willing to invest. Short-term bonds are usually less risky, but may have lower yields. Long-term bonds can offer higher yields, but they are also riskier.
""", isFirstPreview: false),
            LessonContentItem(title: "Compare the yield with\nthe market rates", content: """
Study the current yield of government bonds and compare it with deposit rates and other investment instruments. This will allow you to choose the most profitable option.
""", isFirstPreview: false),
    ]),
    LessonModel(iconId: "lesson_free_2_icon", name: "Stock returns", type: "Stocks", date: "Aug 5, 2024", duration: "5 min", isPremium: false, lessonContent: [
        LessonContentItem(title: "How to calculate the\nprofitability of shares", content: """
Investing in stocks can be an effective way to increase capital, but requires careful analysis and understanding of the basic principles of the stock market. In this text, we will look at the key aspects that will help you assess the potential return on shares and make an informed investment decision.
""", isFirstPreview: true),
        LessonContentItem(title: "Determine the\ninvestment period", content: """
 Decide for how long you plan to invest in stocks. This will help you choose the appropriate method of calculating profitability.
""", isFirstPreview: false),
        LessonContentItem(title: "Figure out the types of\nprofitability", content: """
 There are several types of profitability: current (dividend), full (total income taking into account price changes) and others. Understanding the differences between them will help you make the right choice.
""", isFirstPreview: false),
        LessonContentItem(title: "Use formulas to\ncalculate", content: """
To calculate the current yield, you can use the formula r = d / p * 100%, where r is the current yield, d is the amount of dividends paid for the year, p is the purchase price of the share. Keep in mind that these are only general recommendations, and additional data and consultations with specialists may be required for more accurate calculations.
""", isFirstPreview: false),
    ]),
    LessonModel(iconId: "lesson_free_3_icon", name: "Time to invest", type: "All tools", date: "Jul 11, 2024", duration: "5 min", isPremium: false, lessonContent: [
        LessonContentItem(title: "How to choose bonds\nfrom the state", content: """
Investing is an important tool for creating and increasing capital. However, in order to achieve the desired results, it is necessary to understand for what period it is best to invest funds. Depending on your goals, financial capabilities and risk tolerance, you can choose short-term or long-term investments.
""", isFirstPreview: true),
        LessonContentItem(title: "The first tip", content: """
Before making an investment decision, do some research and determine your financial goal. This will help you understand which investment period will be optimal to achieve your goal.
""", isFirstPreview: false),
        LessonContentItem(title: "The second tip", content: """
Consider your financial capabilities and the level of risk you are willing to take. If you have short-term financial obligations, it is better to choose investments with a shorter term.
""", isFirstPreview: false),
        LessonContentItem(title: "The third tip", content: """
Remember that long-term investing can be more profitable, as it allows you to spread the risks and get a more stable income in the long run. However, it also requires more discipline and patience.
""", isFirstPreview: false),
    ])
]
