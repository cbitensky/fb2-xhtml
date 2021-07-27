<t:stylesheet
	version="1.0"
	xmlns="http://www.w3.org/1999/xhtml"
	xmlns:t="http://www.w3.org/1999/XSL/Transform"
	xmlns:l="http://www.w3.org/1999/xlink"
	xmlns:f="http://www.gribuser.ru/xml/fictionbook/2.0"
	exclude-result-prefixes="l f">

<t:output method="xml" encoding="UTF-8" omit-xml-declaration="yes"/>
<t:strip-space elements="*"/>
<t:preserve-space elements="f:p f:v f:subtitle f:text-author"/>

<t:template match="/f:FictionBook">
<t:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;&#10;</t:text>
<html lang="{//f:lang}">
<t:text>&#10;</t:text><head>
<t:text>&#10;</t:text><meta charset="UTF-8"/>
<t:text>&#10;</t:text><title><t:value-of select="//f:title-info/f:book-title"/></title>
<t:text>&#10;</t:text><link rel="stylesheet" href="/local/css/fb2.css"/>
<t:text>&#10;</t:text></head>
<t:text>&#10;</t:text><body>
<t:apply-templates select="f:body"/>
<t:text>&#10;</t:text></body>
<t:text>&#10;</t:text></html>
</t:template>

<t:template match="f:title">
	<t:text>&#10;</t:text>
	<t:variable name="level" select="count(ancestor::node())-2"/>
	<t:choose>
		<t:when test="$level &lt; 6">
			<t:element name="{concat('h',$level)}">
				<t:apply-templates/>
			</t:element>
		</t:when>
		<t:otherwise>
			<h6><t:apply-templates/></h6>
		</t:otherwise>
	</t:choose>
</t:template>

<t:template match="f:subtitle">
	<t:text>&#10;</t:text>
	<t:variable name="level" select="count(ancestor::node())-1"/>
	<t:choose>
		<t:when test="$level &lt; 6">
			<t:element name="{concat('h',$level)}">
				<t:apply-templates/>
			</t:element>
		</t:when>
		<t:otherwise>
			<h6><t:apply-templates/></h6>
		</t:otherwise>
	</t:choose>
</t:template>


<t:template match="f:title/f:p">
	<t:apply-templates />
	<t:if test="position()!=last()">
		<br/><t:text>&#10;</t:text>
	</t:if>
</t:template>

<t:template match="f:title/f:empty-line">
	<br/><t:text>&#10;</t:text>
</t:template>

<t:template match="f:style">
	<span class="{@name}"><t:apply-templates/></span>
</t:template>

<t:template match="f:style[@name='aux']">
	<small><t:apply-templates/></small>
</t:template>

<t:template match="f:section">
	<t:text>&#10;</t:text><t:element name="{name()}">
		<t:apply-templates select="node()|@*"/>
	<t:text>&#10;</t:text></t:element>
</t:template>

<t:template match="f:section/f:image | f:body/f:image" name="divimage">
	<t:text>&#10;</t:text><figure>
	<t:copy-of select="@id"/>
	<t:text>&#10;</t:text><t:call-template name="image"/>
	<t:if test="@title">
		<t:text>&#10;</t:text><figcaption><t:value-of select="@title"/></figcaption>
	</t:if>
	<t:text>&#10;</t:text></figure>
</t:template>

<t:template match="f:body[@name='notes']">
	<t:text>&#10;</t:text>
	<section class="notes">
	<t:apply-templates/><t:text>&#10;</t:text>
	</section><t:text>&#10;</t:text>
</t:template>

<t:template match="f:p | f:v">
	<t:text>&#10;</t:text><p><t:copy-of select="@id"/><t:apply-templates match="node()|@*"/></p>
</t:template>

<t:template match="@id">
	<t:copy-of select="."/>
</t:template>

<t:template match="f:strong">
	<strong><t:apply-templates/></strong>
</t:template>

<t:template match="f:emphasis">
	<em><t:apply-templates/></em>
</t:template>

<t:template match="f:sup">
	<sup><t:apply-templates/></sup>
</t:template>

<t:template match="f:sub">
	<sub><t:apply-templates/></sub>
</t:template>

<t:template match="f:empty-line">
	<t:text>&#10;</t:text><div class="empty-line"/>
</t:template>

<t:template match="f:section/node()[last()][self::f:empty-line]|f:section/node()[1][self::f:empty-line]">
</t:template>

<t:template match="f:a">
	<t:choose>
		<t:when test="(@type) = 'note'">
			<a class="note" href="{@l:href}"><sup><t:apply-templates/></sup></a>
		</t:when>
		<t:otherwise>
			<a href="{@l:href}"><t:apply-templates/></a>
		</t:otherwise>
	</t:choose>
</t:template>

<t:template match="f:epigraph | f:cite | f:poem">
	<t:text>&#10;</t:text><blockquote class="{name()}">
		<t:apply-templates/>
	<t:text>&#10;</t:text></blockquote>
</t:template>

<t:template match="f:text-author">
	<t:text>&#10;</t:text><p class="author"><t:apply-templates/></p>
</t:template>

<t:template match="f:stanza">
	<t:text>&#10;</t:text><div class="stanza">
		<t:apply-templates/>
	<t:text>&#10;</t:text></div>
</t:template>

<t:template match="f:annotation">
	<t:text>&#10;</t:text>
	<blockquote class="annotation">
	<t:apply-templates/>
	<t:text>&#10;</t:text>
	</blockquote>
</t:template>


<t:template match="f:image" name="image">
	<img>
	<t:copy-of select="@alt"/>
	<t:choose>
		<t:when test="starts-with(@l:href,'#')">
			<t:variable name="href" select="substring-after(@l:href,'#')"/>
			<t:attribute name="src">
				<t:text>data:</t:text>
				<t:value-of select="/f:binary[@id=$href]/@content-type"/>
				<t:text>;base64,</t:text>
				<t:value-of select="translate(normalize-space(/f:binary[@id=$href]), ' ', '')"/>
			</t:attribute>
		</t:when>
		<t:otherwise>
			<t:attribute name="src"><t:value-of select="@l:href"/></t:attribute>
		</t:otherwise>
	</t:choose>
	</img>
</t:template>


<t:template match="f:table">
	<t:text>&#10;</t:text><table>
	<t:text>&#10;</t:text><tbody>
		<t:apply-templates/>
	<t:text>&#10;</t:text></tbody>
	<t:text>&#10;</t:text></table>
</t:template>

<t:template match="f:tr">
	<t:text>&#10;</t:text><tr>
	<t:copy-of select="@*"/>
	<t:apply-templates/></tr>
</t:template>

<t:template match="f:td | f:th">
	<t:element name="{name()}">
	<t:copy-of select="@rowspan|@colspan"/>
	<t:if test="@align">
		<t:attribute name="class"><t:value-of select="@align"/></t:attribute>
	</t:if>
	<t:apply-templates/>
	</t:element>
</t:template>

</t:stylesheet>
