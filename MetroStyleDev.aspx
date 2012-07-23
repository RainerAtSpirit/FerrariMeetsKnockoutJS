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

    <!-- Included CSS Files Development -->
    <link rel="stylesheet" href="stylesheets/foundation-style/globals.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/typography.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/grid.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/ui.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/buttons.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/tabs.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/navbar.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/forms.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/orbit.css"/>
    <link rel="stylesheet" href="stylesheets/foundation-style/reveal.css"/>
    <link rel="stylesheet" href="stylesheets/app.css"/>

    <script src="javascripts/modernizr.foundation.js"></script>
    <!-- IE Fix for HTML5 Tags -->
    <!--[if lt IE 9]>
    <script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>
<body>

<div class="row">
    <div class="twelve columns">
        <h1>The SharePoint DVWP in Ferrari mode strikes again</h1>

        <p>Live demo for an upcoming blog post at <a
                        href="http://rainerat.spirit.de/2012/07/20/the-sharepoint-dvwp-in-ferrari-mode-strikes-again/">
                    Rainer at Spirit</a><br />
            <code>Development version with individual CSS and JS files</code>
        </p>
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

<script src="//ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>

<!-- OOTB Zurb foundation JS files that are not required for this demo -->
<script src="javascripts/foundation/jquery.reveal.js"></script>
<script src="javascripts/foundation/jquery.orbit-1.4.0.js"></script>
<script src="javascripts/foundation/jquery.customforms.js"></script>
<script src="javascripts/foundation/jquery.placeholder.min.js"></script>
<script src="javascripts/foundation/jquery.tooltips.js"></script>
<script src="javascripts/app.js"></script>
<script type="text/javascript" src="javascripts/app/MetroJs.js"></script>
<script type="text/javascript" src="javascripts/app/jquery.prettyDate.js"></script>

<!-- Inline script for demo  purposes only! -->
<script type="text/javascript">
    $(document).ready(function () {
        var doBind = (typeof (window.bindAppBarKeyboard) == "undefined" || window.bindAppBarKeyboard);

        // apply regular slide universally unless .exclude class is applied
        // NOTE: The default options for each liveTile are being pulled from the 'data-' attributes
        $(".live-tile, .flip-list").not(".exclude").liveTile();

        // showing UTC date as prettyDate
        $('span.prettyDate').prettyDate();

        // Showing default list/library URL on click
        $("#metroTiles").on("click", ".live-tile", function (event) {
            var message = "We could now redirect you to the default SharePoint view\n\nBut we won't ;-)\n\n",
                    url = $(this).data('target');
            alert(message + url);
        });
    });
</script>

<SharePoint:FormDigest ID="FormDigest1" runat="server"></SharePoint:FormDigest>

</body>
</html>
