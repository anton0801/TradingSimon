import Foundation

class GraphicViewGenerator {
    func getGraphicCode(ticker: String) -> String {
        return """
            <!DOCTYPE html>
            <html>
            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <script src="https://s3.tradingview.com/tv.js"></script>
        
                <style>
                    body {
                        background-color: #03034A;
                    }
                </style>
            </head>
            <body>
                <div id="chart" style="height: 100vh; width: 100%;"></div>
                <script type="text/javascript">
                new TradingView.widget({
                    "container_id": "chart",
                    "autosize": true,
                    "symbol": "NASDAQ:\(ticker)",
                    "interval": "D",
                    "theme": "dark",
                    "style": "1",
                    "locale": "en",
                    "hide_top_toolbar": true,
                    "hide_legend": true,
                    "hide_side_toolbar": true,
                    "withdateranges": false,
                    "details": false,
                    "studies": [],
                    "enable_publishing": false,
                    "allow_symbol_change": true,
                    "save_image": false,
                    "show_popup_button": false,
                    "toolbar_bg": "#f1f3f6",
                    "hidevolume": true,  // Скрыть объёмы
                    "backgroundColor": "transparent"
                });
                </script>
            </body>
            </html>
        """
    }
}
