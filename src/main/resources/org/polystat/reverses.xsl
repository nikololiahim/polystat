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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" id="reverses" version="2.0">
  <xsl:strip-space elements="*"/>
  <xsl:param name="out"/>
  <xsl:template name="r">
    <xsl:param name="result" select="''"/>
    <xsl:param name="o" as="node()"/>
    <xsl:param name="attr" as="node()"/>
    <xsl:for-each select="$o/o">
      <xsl:variable name="i">
        <xsl:element name="r">
          <xsl:attribute name="f" select="$o/@base"/>
          <xsl:attribute name="pos" select="position()"/>
          <xsl:attribute name="tau" select="$o/@line"/>
          <xsl:copy-of select="$result"/>
        </xsl:element>
      </xsl:variable>
      <xsl:choose>
        <xsl:when test="@base=$attr/@name and @ref=$attr/@line">
          <xsl:copy-of select="$i"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:call-template name="r">
            <xsl:with-param name="result">
              <xsl:copy-of select="$i"/>
            </xsl:with-param>
            <xsl:with-param name="attr" select="$attr"/>
            <xsl:with-param name="o" select="."/>
          </xsl:call-template>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>
  <xsl:template match="o[not(@base) and not(o) and parent::o[o[@name='@']]]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:call-template name="r">
        <xsl:with-param name="attr" select="."/>
        <xsl:with-param name="o" select="parent::o/o[@name='@']"/>
      </xsl:call-template>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>
