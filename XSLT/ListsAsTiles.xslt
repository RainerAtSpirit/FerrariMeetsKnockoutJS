<xsl:stylesheet version="1.0" exclude-result-prefixes="xsl ddwrt msxsl"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:ddwrt2="urn:frontpage:internal"
                xmlns:ddwrt="http://schemas.microsoft.com/WebParts/v2/DataView/runtime"
                xmlns:msxsl="urn:schemas-microsoft-com:xslt">
    <xsl:output method="html" version="1.0" encoding="UTF-8" indent="no"/>
    <xsl:variable name="Rows"
                  select="/dsQueryResponse/Rows/Row[not(@__spHidden = 'True') and not(contains(@__spDefaultViewUrl, '_catalogs')) and @__spTitle != 'ServiceFiles']"/>

    <!-- configMap allows configuration per BaseTemplate -->
    <xsl:variable name="configMap">
        <global>
            <maxTiles>12</maxTiles>
            <wideTiles>3</wideTiles>
            <backTileTitle>Last updated</backTileTitle>
        </global>
        <tiles>
            <item BaseTemplate="Contacts" color="lime" icon="images/48/bomb.png"/>
            <item BaseTemplate="DocumentLibrary" color="teal" icon="images/48/file.png" data-mode="slide"
                  data-direction="vertical"/>
            <item BaseTemplate="GenericList" color="green" icon="images/48/inventory2.png" data-mode="flip"
                  data-direction="vertical"/>
            <item BaseTemplate="Tasks" color="red" icon="images/48/bomb.png" data-mode="flip"
                  data-direction="horizontal"/>
            <item BaseTemplate="GanttTasks" color="purple" icon="images/48/hand_thumbsup.png"/>
            <item BaseTemplate="IssueTracking" color="pink" icon="images/48/clipboard.png" data-mode="slide"
                  data-direction="vertical"/>
            <item BaseTemplate="Links" color="lime" icon="images/48/link.png"/>
            <item BaseTemplate="WebPageLibrary" color="brown" icon="images/48/clipboard.png"/>
            <item BaseTemplate="Events" color="mango" icon="images/48/clipboard.png"/>
            <item BaseTemplate="unknown" color="blue" icon="images/48/smiley_sad.png"/>
        </tiles>
    </xsl:variable>

    <!-- shortcuts to globalConfig and tilesConfig -->
    <xsl:variable name="globalConfig" select="msxsl:node-set($configMap)/global"/>
    <xsl:variable name="tilesConfig" select="msxsl:node-set($configMap)/tiles"/>

    <!-- itemsInList sorted by @__spItemCount descending. Used to distinguish between normal and wide tiles  -->
    <xsl:variable name="itemsInList">
        <xsl:for-each select="$Rows">
            <xsl:sort select="@__spItemCount" order="descending" data-type="number"/>
            <item id="{@__spID}" count="{@__spItemCount}" pos="{position()}"/>
        </xsl:for-each>
    </xsl:variable>

    <xsl:template match="/">
        <xsl:for-each select="$Rows">
            <!-- This complex sort criteria is required because __spModified is localized. Using information inside __spPropertiesXml instead -->
            <xsl:sort
                    select="translate(substring-before(substring-after(@__spPropertiesXml, 'Modified=&quot;'), '&quot; LastDeleted'), ' :', '')"
                    order="descending" data-type="number"/>
            <xsl:if test="position() &lt;= $globalConfig/maxTiles">
                <xsl:call-template name="Tile"/>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>

    <xsl:template name="Tile">
        <!-- Mashup of $configMap and $ itemsInList for the current item -->
        <xsl:variable name="coreMetaData">
            <xsl:call-template name="MetaData">
                <xsl:with-param name="baseTemplate" select="@__spBaseTemplate"/>
                <xsl:with-param name="spID" select="@__spID"/>
                <xsl:with-param name="spPropertiesXml" select="@__spPropertiesXml"/>
            </xsl:call-template>
        </xsl:variable>
        <!-- shortcut for accessing $coreMetaData -->
        <xsl:variable name="t" select="msxsl:node-set($coreMetaData)"/>

        <xsl:call-template name="TileTemplate">
            <xsl:with-param name="t" select="$t" />
        </xsl:call-template>
    </xsl:template>

    <xsl:template name="TileTemplate">
        <xsl:param name="t" />
        <div class="live-tile {$t/item/@color} {$t/size}"
             data-stops="100%"
             data-speed="750"
             data-delay="-1"
             data-mode="{$t/item/@data-mode}"
             data-direction="{$t/item/@data-direction}"
             data-target="{@__spDefaultViewUrl}"
             data-baseTemplate="{@__spBaseTemplate}">
            <span class="tile-title">
                <xsl:value-of select="@__spTitle"/>
                <span class="badge right">
                    <xsl:value-of select="@__spItemCount"/>
                </span>
            </span>
            <div>
                <img src="{$t/item/@icon}" class="micon"/>
            </div>
            <div>
                <h3>
                   <xsl:value-of select="$globalConfig/backTileTitle" />
                </h3>
                <span class="prettyDate" title="{$t/prettyDate}">
                    <xsl:value-of select="$t/prettyDate"/>
                </span>
            </div>
        </div>
    </xsl:template>

    <xsl:template name="MetaData">
        <xsl:param name="spID"/>
        <xsl:param name="baseTemplate"/>
        <xsl:param name="spPropertiesXml"/>
        <!-- accessible via $t/item/@XXXX. Available attributes see $configMap/tiles/item/@XXXX -->
        <xsl:choose>
            <xsl:when test="$tilesConfig/item[@BaseTemplate = $baseTemplate]">
                <xsl:copy-of select="$tilesConfig/item[@BaseTemplate = $baseTemplate]"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:copy-of select="$tilesConfig/item[@BaseTemplate = 'unknown']"/>
            </xsl:otherwise>
        </xsl:choose>
        <!-- accessible via $t/size -->
        <size>
            <xsl:choose>
                <xsl:when test="msxsl:node-set($itemsInList)/item[@id = $spID]/@pos &lt;= $globalConfig/wideTiles">
                    <xsl:text>wide</xsl:text>
                </xsl:when>
                <xsl:otherwise/>
            </xsl:choose>
        </size>
        <prettyDate>
            <xsl:variable name="DateRaw"
                          select="translate(substring-before(substring-after($spPropertiesXml, 'Modified=&quot;'), '&quot; LastDeleted'), ' ', 'T')"/>
            <xsl:value-of
                    select="concat(substring($DateRaw, 1, 4), '-', substring($DateRaw, 5, 2), '-', substring($DateRaw, 7,2), substring($DateRaw, 9), 'Z')"/>
        </prettyDate>
    </xsl:template>
</xsl:stylesheet>
