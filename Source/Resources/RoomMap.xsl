<?xml version="1.0" encoding="windows-1251" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="text" encoding="windows-1251"/>
  
  <!--Весь документ-->
  <xsl:template match="/">
    <xsl:text>{\rtf\ansi\ansicpg1251 {\fonttbl{\f0 Arial;}}\f0\fs24&#10;</xsl:text>
    <xsl:text>\paperh11906\paperw16838\landscape&#10;</xsl:text>
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
    <xsl:text>{\qc\fs48 Преподаватель: </xsl:text>
    <xsl:call-template name="MaskRtf">
      <xsl:with-param name="text" select="normalize-space(Boss)"/>
    </xsl:call-template>
    <xsl:text>\par}&#10;</xsl:text>
    <!--Ряды парт-->
    <xsl:call-template name="tRoomRow">
      <xsl:with-param name="row" select="1"/>
    </xsl:call-template>
    <xsl:call-template name="tRoomRow">
      <xsl:with-param name="row" select="2"/>
    </xsl:call-template>
    <xsl:call-template name="tRoomRow">
      <xsl:with-param name="row" select="3"/>
    </xsl:call-template>
    <xsl:call-template name="tRoomRow">
      <xsl:with-param name="row" select="4"/>
    </xsl:call-template>
    <xsl:call-template name="tRoomRow">
      <xsl:with-param name="row" select="5"/>
    </xsl:call-template>
  </xsl:template>
  
  <!--Один ряд парт-->
  <xsl:template name="tRoomRow">
    <xsl:param name="row"/>
    
    <xsl:text>\par&#10;</xsl:text>
    <xsl:text>\trowd\trrh-1418&#10;</xsl:text>
    <xsl:text>\clbrdrt\brdrs\brdrw50\clbrdrl\brdrs\brdrw50\clbrdrb\brdrs\brdrw50\clbrdrr\brdrs\brdrw1\cellx2552&#10;</xsl:text>
    <xsl:text>\clbrdrt\brdrs\brdrw50\clbrdrl\brdrs\brdrw1\clbrdrb\brdrs\brdrw50\clbrdrr\brdrs\brdrw50\cellx5103&#10;</xsl:text>
    <xsl:text>\cellx5387&#10;</xsl:text>
    <xsl:text>\clbrdrt\brdrs\brdrw50\clbrdrl\brdrs\brdrw50\clbrdrb\brdrs\brdrw50\clbrdrr\brdrs\brdrw1\cellx7938&#10;</xsl:text>
    <xsl:text>\clbrdrt\brdrs\brdrw50\clbrdrl\brdrs\brdrw1\clbrdrb\brdrs\brdrw50\clbrdrr\brdrs\brdrw50\cellx10490&#10;</xsl:text>
    <xsl:text>\cellx10773&#10;</xsl:text>
    <xsl:text>\clbrdrt\brdrs\brdrw50\clbrdrl\brdrs\brdrw50\clbrdrb\brdrs\brdrw50\clbrdrr\brdrs\brdrw1\cellx13325&#10;</xsl:text>
    <xsl:text>\clbrdrt\brdrs\brdrw50\clbrdrl\brdrs\brdrw1\clbrdrb\brdrs\brdrw50\clbrdrr\brdrs\brdrw50\cellx15876&#10;</xsl:text>
    <xsl:text>\pard\intbl&#10;</xsl:text>
    <xsl:call-template name="tPers">
      <xsl:with-param name="id" select="TableList/Table[Row=$row][Col=1]/Left"/>
    </xsl:call-template>
    <xsl:text>\cell&#10;</xsl:text>
    <xsl:call-template name="tPers">
      <xsl:with-param name="id" select="TableList/Table[Row=$row][Col=1]/Right"/>
    </xsl:call-template>
    <xsl:text>\cell&#10;</xsl:text>
    <xsl:text>\cell&#10;</xsl:text>
    <xsl:call-template name="tPers">
      <xsl:with-param name="id" select="TableList/Table[Row=$row][Col=2]/Left"/>
    </xsl:call-template>
    <xsl:text>\cell&#10;</xsl:text>
    <xsl:call-template name="tPers">
      <xsl:with-param name="id" select="TableList/Table[Row=$row][Col=2]/Right"/>
    </xsl:call-template>
    <xsl:text>\cell&#10;</xsl:text>
    <xsl:text>\cell&#10;</xsl:text>
    <xsl:call-template name="tPers">
      <xsl:with-param name="id" select="TableList/Table[Row=$row][Col=3]/Left"/>
    </xsl:call-template>
    <xsl:text>\cell&#10;</xsl:text>
    <xsl:call-template name="tPers">
      <xsl:with-param name="id" select="TableList/Table[Row=$row][Col=3]/Right"/>
    </xsl:call-template>
    <xsl:text>\cell&#10;</xsl:text>
    <xsl:text>\row&#10;</xsl:text>
    <xsl:text>\pard&#10;</xsl:text>    
  </xsl:template>
  
  <!--Личность-->
  <xsl:template name="tPers">
    <xsl:param name="id"/>

    <xsl:for-each select="/OlimpSet/PersList/Pers[Id=$id]">
      <xsl:call-template name="MaskRtf">
        <xsl:with-param name="text" select="normalize-space(Fio)"/>
      </xsl:call-template>
      <xsl:text>\par&#10;</xsl:text>
      <xsl:value-of select="Level"/>
      <xsl:call-template name="MaskRtf">
        <xsl:with-param name="text" select="normalize-space(Symbol)"/>
      </xsl:call-template>
      <xsl:if test="normalize-space(Rem)!=''">
        <xsl:text> {\i (</xsl:text>
        <xsl:call-template name="MaskRtf">
          <xsl:with-param name="text" select="normalize-space(Rem)"/>
        </xsl:call-template>
        <xsl:text>)}</xsl:text>
      </xsl:if>
    </xsl:for-each>    
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