<?xml version="1.0" encoding="windows-1251" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="windows-1251"/>

  <xsl:key name="keyPers" match="/OlimpSet/PersList/Pers" use="Id"/>
  
  <!--Весь документ-->
  <xsl:template match="/">
    <xsl:text>{\rtf\ansi\ansicpg1251 {\fonttbl{\f0 Arial;}}\f0\fs24&#10;</xsl:text>
    <xsl:text>\paperw11906\paperh16838&#10;</xsl:text>
    <xsl:text>\margl567\margr567\margt567\margb567&#10;</xsl:text>
    <xsl:for-each select="/OlimpSet/RoomList/Room">
      <xsl:if test="position()!=1">
        <xsl:text>\page&#10;</xsl:text>
      </xsl:if>
      <xsl:call-template name="tRoom"/>      
    </xsl:for-each>
    <xsl:text>}</xsl:text>
  </xsl:template>
  
  <!--Комната-->
  <xsl:template name="tRoom">
    <!--Заголовок-->
    <xsl:text>{\qc\b\fs72 Кабинет №</xsl:text>
    <xsl:call-template name="MaskRtf">
      <xsl:with-param name="text" select="normalize-space(NumRoom)"/>
    </xsl:call-template>
    <xsl:text>\par}&#10;</xsl:text>
    <xsl:text>{\qc\fs40 Преподаватель: </xsl:text>
    <xsl:call-template name="MaskRtf">
      <xsl:with-param name="text" select="normalize-space(Boss)"/>
    </xsl:call-template>
    <xsl:text>\par}&#10;</xsl:text>
    <!--Заголовок таблицы-->
    <xsl:text>\trowd\trkeep\trhdr&#10;</xsl:text>
    <xsl:call-template name="tDefRow"/>
    <xsl:text>{\b № п/п}\cell&#10;</xsl:text>
    <xsl:text>{\b Класс}\cell&#10;</xsl:text>
    <xsl:text>{\b Фамилия Имя Отчество}\cell&#10;</xsl:text>
    <xsl:text>\row&#10;</xsl:text>
    <xsl:text>\pard&#10;</xsl:text>
    <!--Список-->
    <xsl:for-each select="key('keyPers', TableList/Table/Left[.!=0]) | key('keyPers', TableList/Table/Right[.!=0])">
      <xsl:sort select="Level" data-type="number"/>
      <xsl:sort select="normalize-space(Symbol)"/>
      <xsl:sort select="normalize-space(Fio)"/>
      <xsl:sort select="Id" data-type="number"/>

      <xsl:text>\trowd\trkeep&#10;</xsl:text>
      <xsl:call-template name="tDefRow"/>

      <!--№ п/п-->
      <xsl:text>\qr </xsl:text>
      <xsl:value-of select="position()"/>
      <xsl:text>\cell&#10;</xsl:text>

      <!--Класс-->
      <xsl:text>\qc </xsl:text>
      <xsl:value-of select="Level"/>
      <xsl:call-template name="MaskRtf">
        <xsl:with-param name="text" select="normalize-space(Symbol)"/>
      </xsl:call-template>
      <xsl:text>\cell&#10;</xsl:text>

      <!--Фамилия Имя Отчество-->
      <xsl:text>\ql </xsl:text>
      <xsl:call-template name="MaskRtf">
        <xsl:with-param name="text" select="normalize-space(Fio)"/>
      </xsl:call-template>
      <xsl:if test="normalize-space(Rem)!=''">
        <xsl:text> {\i (</xsl:text>
        <xsl:call-template name="MaskRtf">
          <xsl:with-param name="text" select="normalize-space(Rem)"/>
        </xsl:call-template>
        <xsl:text>)}</xsl:text>
      </xsl:if>
      <xsl:text>\cell&#10;</xsl:text>

      <xsl:text>\row&#10;</xsl:text>
      <xsl:text>\pard&#10;</xsl:text>
    </xsl:for-each>
    
    
  </xsl:template>

  <!--Описание строки таблицы-->
  <xsl:template name="tDefRow">
    <xsl:text>\clbrdrt\brdrs\brdrw1\clbrdrl\brdrs\brdrw1\clbrdrb\brdrs\brdrw1\clbrdrr\brdrs\brdrw1\cellx851&#10;</xsl:text>
    <xsl:text>\clbrdrt\brdrs\brdrw1\clbrdrl\brdrs\brdrw1\clbrdrb\brdrs\brdrw1\clbrdrr\brdrs\brdrw1\cellx1701&#10;</xsl:text>
    <xsl:text>\clbrdrt\brdrs\brdrw1\clbrdrl\brdrs\brdrw1\clbrdrb\brdrs\brdrw1\clbrdrr\brdrs\brdrw1\cellx10773&#10;</xsl:text>
    <xsl:text>\pard\intbl&#10;</xsl:text>
  </xsl:template>

  <!--MaskRtf-->
  <xsl:template name="MaskRtf">
    <xsl:param name="text"/>
    <xsl:variable name="a1">
      <xsl:call-template name="replace-string">
        <xsl:with-param name="text" select="$text"/>
        <xsl:with-param name="replace" select="'\'"/>
        <xsl:with-param name="with" select="'\\'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="a2">
      <xsl:call-template name="replace-string">
        <xsl:with-param name="text" select="$a1"/>
        <xsl:with-param name="replace" select="'&#10;'"/>
        <xsl:with-param name="with" select="'\par '"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="a3">
      <xsl:call-template name="replace-string">
        <xsl:with-param name="text" select="$a2"/>
        <xsl:with-param name="replace" select="'{'"/>
        <xsl:with-param name="with" select="'\{'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="a4">
      <xsl:call-template name="replace-string">
        <xsl:with-param name="text" select="$a3"/>
        <xsl:with-param name="replace" select="'}'"/>
        <xsl:with-param name="with" select="'\}'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="a5">
      <xsl:call-template name="replace-string">
        <xsl:with-param name="text" select="$a4"/>
        <xsl:with-param name="replace" select="'&#xA0;'"/>
        <xsl:with-param name="with" select="'\~'"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:value-of select="$a5"/>
  </xsl:template>

  <!--StringReplace-->
  <xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"/>
        <xsl:value-of select="$with"/>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text" select="substring-after($text,$replace)"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="with" select="$with"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>