<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
xmlns="http://www.w3.org/1999/xhtml">

    <xsl:template match="/">
        <xsl:call-template name="NASLOV"></xsl:call-template>
        <xsl:call-template name="USPOREĐIVANJE_POJEDINAČNO"></xsl:call-template>
        <xsl:call-template name="RJEČNIK"></xsl:call-template>
        <xsl:call-template name="PREBROJAVANJE"></xsl:call-template>
    </xsl:template>
    
    <!-- XSL predložak NASLOV -->
    <xsl:template name="NASLOV">
        <xsl:param name="naslov" select="/TEI/teiHeader/fileDesc/titleStmt/title" />
                <b><xsl:value-of select="$naslov"/></b>
        <p></p>
    </xsl:template>
	
	<xsl:template name="USPOREĐIVANJE_POJEDINAČNO">
        <!-- <xsl:param name="dio_teksta" select="//div" /> -->
            <table border="2">
                <tbody>
                    <!-- <xsl:for-each select="$dio_teksta"> -->
					<xsl:for-each select="//lg/l">				
						<tr>
							<td><xsl:text>Bibliografski izvor</xsl:text></td>
						    
							<xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/listWit/witness/bibl">
								 <!-- <xsl:sort select="../@xml:id"/> -->
								 <!-- <xsl:sort select="author/persName/surname"/> --> 
								 <xsl:sort select="date"/> 
										<td bgcolor="lightgray">
										<b><xsl:value-of select="title"/></b>
										<br/>
										<i><xsl:value-of select="author"/></i>
										<xsl:if test="author">
										<xsl:text>, </xsl:text>
										</xsl:if>
										<xsl:value-of select="date"/>
										</td>
							</xsl:for-each>
						</tr>
						
						<tr>
						<td><xsl:text>Vrsta katekizma</xsl:text></td>
						<xsl:for-each select="/TEI/teiHeader/fileDesc/sourceDesc/listWit/witness/bibl">
								 <!-- <xsl:sort select="../@xml:id"/> -->
								 <!-- <xsl:sort select="author/persName/surname"/> -->
								  <xsl:sort select="date/@when"/> 
							
								<xsl:choose>
									<xsl:when test="note='Katekizmi kanizijevske tradicije'">
										<td bgcolor="#C2D69B"><xsl:value-of select="note"/></td> 
									</xsl:when>
									<xsl:when test="note='Katekizmi bellarminovske tradicije'">
										<td bgcolor="#CCC0D9"><xsl:value-of select="note"/></td> 
									</xsl:when>
									<xsl:when test="note='Katekizam po uzoru na Rimski katekizam'">
										<td bgcolor="#FABF8F"><xsl:value-of select="note"/></td> 
									</xsl:when>
									<xsl:when test="note='Kontroverzijski katekizam'">
										<td bgcolor="#FFFF00"><xsl:value-of select="note"/></td> 
									</xsl:when>
									<xsl:when test="note='Katekizam neutvrđene katekizamske tradicije'">
										<td bgcolor="#669900"><xsl:value-of select="note"/></td> 
									</xsl:when>
									<xsl:when test="note='Katekizamska pjesmarica'">
										<td bgcolor="#FF66FF"><xsl:value-of select="note"/></td> 
									</xsl:when>
									<xsl:when test="note='Katekizam reformnog katolicizma'">
										<td bgcolor="#CC6600"><xsl:value-of select="note"/></td> 
									</xsl:when>
								
									<xsl:otherwise>  
										<td><xsl:value-of select="note"/></td>
									</xsl:otherwise> 
								</xsl:choose>
							
						</xsl:for-each>
						</tr>
							
						<tr>
                            <td align="center">
							<xsl:text>Red. br. zapovijedi:</xsl:text><br/>
							<h2><xsl:value-of select="@n"/></h2>
							</td>
                           		                 
										<xsl:for-each select="app/rdg">
										<xsl:sort select="@wit"/> 
					<!-- <xsl:sort select="/TEI/teiHeader/fileDesc/sourceDesc/listWit/witness/bibl/date"/> -->
																										
										<td> 
											<xsl:value-of select="node()"/>
											<xsl:for-each select="ref">
												<a href="{@target}"> <xsl:value-of select="."/></a>
												<xsl:value-of select="./following::text()"/>				    
											</xsl:for-each>												
											
											<xsl:value-of select="./following::text()"/>
											<br/><a href="#" title="{note}">[tumačenje]</a>
											<xsl:for-each select="s">
											<hr color="black" width="100%" />
											<td>
												<xsl:value-of select="."/>
											</td>
											</xsl:for-each>
										</td>
											
																						
										</xsl:for-each>                         
						</tr>
						<!-->
						<tr>
						<td><xsl:text>Tumačenje biblijske zapovijedi</xsl:text></td>					
						<td colspan="11"><xsl:value-of select="note"/></td>					
						</tr>
						-->
						<tr>
						<td bgcolor="gray" colspan="12"></td>
						</tr>
						
						
						
						</xsl:for-each>
                      <!--  </xsl:for-each>   -->                          
                       
                </tbody>           
            </table>
    </xsl:template>
	
    <!-- XSL predložak RJEČNIK -->
    <xsl:template name="RJEČNIK">
                <xsl:for-each select="//entry">
                    <a name="{@xml:id}" id="{@xml:id}"></a>
                    <table border="0">
                        <tr>
                            <td><b><xsl:value-of select="form/orth" /></b></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td><xsl:value-of select="sense/usg"/></td>
                        </tr>
                    </table>
                    <br/>
                </xsl:for-each>
    </xsl:template>
    
    <!-- XSL predložak PREBROJAVANJA -->
    <xsl:template name="PREBROJAVANJE">
        <xsl:param name="element" select="//c"></xsl:param>
        <xsl:param name="atribut" select="@ana"></xsl:param>
        <xsl:variable name="naziv_elementa">c</xsl:variable>
        <xsl:variable name="naziv_fonema">#TPS-Pr</xsl:variable>
        <xsl:if test="$element">
        <xsl:text>Broj elemenata </xsl:text> 
        <xsl:value-of select="$naziv_elementa"></xsl:value-of>
        <xsl:text> kojim je označen fonem  </xsl:text>
        <xsl:value-of select="$naziv_fonema"></xsl:value-of>
           <xsl:text> : </xsl:text>
        <xsl:value-of select="count($element[@ana=$naziv_fonema])"/><br/>
        <xsl:for-each select="$element[@ana=$naziv_fonema]">
            <table border="1"><tr><td><xsl:value-of select="../self::node()"/></td></tr></table>
            <xsl:text> </xsl:text>
        </xsl:for-each>
        </xsl:if>
    </xsl:template>
    
</xsl:stylesheet>
