<!--- 	 coldfusion component for retrieving case states for counties (WIP)		--->
<cfcomponent>
  <cffunction name="getStats" access="public" output="false" returntype="struct">
    <cfargument name="structform" required="true" type="any" />
    <cfset var resObj = {}>
 	<cfset queryString  = "WHERE ">
		
	<cfif IsDefined("structform.counties") >
		<cfset queryString  = queryString & "(Name LIKE ">
		<cfloop array = #structform.counties# index="County">
			<cfset queryString  = queryString & "'%#County#'">
			<cfif #County# neq ArrayLast(#structform.counties#)>
				<cfset queryString  = queryString & " OR Name LIKE ">
			</cfif>	
		</cfloop>
		<cfset queryString  = queryString & ") AND ">
	</cfif>
			
	<cfif IsDefined("structform.between")>
			<cfset queryString  = queryString & "Date BETWEEN '#structform.between[1]#' AND '#structform.between[2]#'">
	</cfif>
		
	<cfif IsDefined("structform.date")>
			<cfset queryString  = queryString & "Date = '#structform.date#'">
	</cfif>
	
	<cfquery datasource="covid-database" name ="Cases">
		SELECT Date,Name,Count FROM Cases INNER JOIN Counties ON Cases.CountyID = Counties.ID #preserveSingleQuotes(queryString)#;
	</cfquery>	
	<cfquery datasource="covid-database" name ="Deaths">
		SELECT Date,Name,Count FROM Deaths INNER JOIN Counties ON Deaths.CountyID = Counties.ID 
		#preserveSingleQuotes(queryString)#;
	</cfquery>	
	<cfquery datasource="covid-database" name ="Recoveries">
		SELECT Date,Name,Count FROM Recoveries INNER JOIN Counties ON Recoveries.CountyID = Counties.ID 
		#preserveSingleQuotes(queryString)#;
	</cfquery>	
	<cfset test = []>
	<cfloop index="i" from="1" to="#Cases.RecordCount#">
		<cfscript>
			stateCounty=listToArray(Cases.Name[i],":",false,true);
			row = {
			  Date:"#Cases.Date[i]#",
			  State: "#stateCounty[1]#",
			  Name: "#stateCounty[2]#",
			  Recoveries: #Recoveries.Count[i]#,
			  ConfirmedCases: #Cases.Count[i]#,
			  ConfirmedDeaths: #Deaths.Count[i]#
		   };
			ArrayAppend(test,row,"false");
		</cfscript>
	</cfloop>
	
	<cfset resObj["Response"] = test>
	<cfset resObj["sql"] = queryString>
    <cfreturn resObj>
  </cffunction>
</cfcomponent> 