<?xml version="1.0"?>
<!--
The MIT License (MIT)

Copyright (c) 2020-2021 Polystat.org

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included
in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" id="data-to-attrs" version="2.0">
  <!--
  This XSL takes all constants (data) anywhere in the object
  and turns them into bound attributes. Each new attributes
  gets a name that starts with a &#x3BA; and ends with a
  unique number.

  We need this because we want to turn the object into
  a functional aggregate, which be definition consists of functions
  and variables (no data, no constants).
  -->
  <xsl:strip-space elements="*"/>
  <xsl:template match="o[o[@name='@']]">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      <xsl:for-each select=".//o[@base and @data and not(o)]">
        <xsl:element name="o">
          <xsl:attribute name="name">
            <xsl:text>&#x3BA;</xsl:text>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="count(./preceding::*) + count(ancestor::*) + 1"/>
            <xsl:text>-</xsl:text>
            <xsl:value-of select="@line"/>
          </xsl:attribute>
          <xsl:attribute name="line">
            <xsl:value-of select="@line"/>
          </xsl:attribute>
          <xsl:attribute name="data">
            <xsl:value-of select="text()"/>
          </xsl:attribute>
        </xsl:element>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
