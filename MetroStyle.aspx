<!DOCTYPE HTML>
<%@ Page language="C#" inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register Tagprefix="SharePoint"
        Namespace="Microsoft.SharePoint.WebControls"
        Assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Import Namespace="Microsoft.SharePoint" %>
<%@ Register tagprefix="WebPartPages" namespace="Microsoft.SharePoint.WebPartPages" assembly="Microsoft.SharePoint, Version=14.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
        <!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->
        <!--[if lt IE 7]>
        <html class="no-js lt-ie9 lt-ie8 lt-ie7" lang="en"> <![endif]-->
        <!--[if IE 7]>
        <html class="no-js lt-ie9 lt-ie8" lang="en"> <![endif]-->
        <!--[if IE 8]>
        <html class="no-js lt-ie9" lang="en"> <![endif]-->
        <!--[if gt IE 8]><!--> <html class="no-js" lang="en"> <!--<![endif]-->
<head>
    <meta charset="utf-8"/>

    <!-- Set the viewport width to device width for mobile -->
    <meta name="viewport" content="width=device-width"/>

    <title>The SharePoint DVWP in Ferrari mode strikes again</title>

    <!-- Included metroJS CSS  -->
    <link rel="stylesheet" type="text/css" href="stylesheets/MetroJs.css"/>

    <!-- Included CSS Files Production -->
    <link rel="stylesheet" href="stylesheets/prod.css"/>

    <script src="javascripts/modernizr.foundation.js"></script>
    <script type="text/javascript">
	  var _gaq = _gaq || [];
	  _gaq.push(['_setAccount', 'UA-31072569-1']);
	  _gaq.push(['_trackPageview']);
	</script>
    <!-- IE Fix for HTML5 Tags -->
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>
<body>

<div class="row">
    <div class="twelve columns">
        <h1>The SharePoint DVWP in Ferrari mode strikes again</h1>
        <h2 class="subheader">Running on premise on SP2010 foundation</h2>
        <p>More info <a
                href="http://rainerat.spirit.de/2012/07/20/the-sharepoint-dvwp-in-ferrari-mode-strikes-again/">
            RainerAtSpirit's blog</a>. The same version is running hosted on <a
                href="https://spirit2013preview-public.sharepoint.com/zurb/MetroStyle.aspx">SP2013
            Preview</a></p>
        <hr/>
    </div>
    <div id="metroTiles" class="twelve columns tiles">
        <!-- DVWP with DataSourceMode="ListOfLists" -->
        <WebPartPages:DataFormWebPart runat="server" AsyncRefresh="False" FrameType="None" SuppressWebPartChrome="True">
            <ParameterBindings></ParameterBindings>
            <DataFields></DataFields>
            <XslLink>XSLT/ListsAsTiles.xslt</XslLink>
            <Xsl></Xsl>
            <DataSources>
                <SharePoint:SPDataSource runat="server" DataSourceMode="ListOfLists" SelectCommand=""
                                         ID="dsLists"></SharePoint:SPDataSource>
            </DataSources>
        </WebPartPages:DataFormWebPart>
        <!-- DVWP with DataSourceMode="ListOfLists" -->
    </div>
</div>

<!-- Production JS files -->
<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
<script type="text/javascript" src="javascripts/app/MetroJs.js"></script>
<script type="text/javascript" src="javascripts/app/jquery.prettyDate.js"></script>

<!-- Inline script for easier readability in HTML source mode -->
<script type="text/javascript">
    $(document).ready(function () {
        var doBind = (typeof (window.bindAppBarKeyboard) == "undefined" || window.bindAppBarKeyboard);

        // apply regular slide universally unless .exclude class is applied
        // NOTE: The default options for each liveTile are being pulled from the 'data-' attributes
        $(".live-tile, .flip-list").not(".exclude").liveTile();

        // showing UTC date as prettyDate
        $('span.prettyDate').prettyDate({ isUTC: true });

        // Showing default list/library URL on click
        $("#metroTiles").on("click", ".live-tile", function (event) {
            var message = "We could now redirect you to the default SharePoint view\n\nBut we won't ;-)\n\n",
                    url = $(this).data('target');
            alert(message + url);
        });
    });
</script>
<SharePoint:FormDigest ID="FormDigest1" runat="server"></SharePoint:FormDigest>
<script type="text/javascript">
	  (function() {
	    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
	    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
	    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();
</script>
</body>
</html>
