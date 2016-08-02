React = require 'react'
Typography = require 'typography'
prune = require 'underscore.string/prune'

{TypographyStyle} = require 'blog-typography'
{prefixLink} = require 'gatsby-helpers'

module.exports = React.createClass
  getDefaultProps: ->
    body: ""

  render: ->
    if @props.page
      description = prune(@props.page.data?.body.replace(/<[^>]*>/g, ''), 200)
      if @props.page?.path is "/"
        title = "Andrew Drozdov"
      else if @props.page?.data?.title?
        title = @props.page.data.title + " | Andrew Drozdov"
      else
        title = "Andrew Drozdov"

    if process.env.NODE_ENV is "production"
      css = <style dangerouslySetInnerHTML={{__html: require('!raw!./public/styles.css')}} />

    <html lang="en">
      <head>
        <meta charSet="utf-8"/>
        <meta httpEquiv="X-UA-Compatible" content="IE=edge"/>
        <meta name='viewport' content='user-scalable=1 width=device-width, initial-scale=1.0 maximum-scale=1.0'/>
        <title>{title}</title>
        <meta name="description" content={description}/>

        <meta property="twitter:account_id" content="10907062"/>
        <meta name="twitter:card" content="summary"/>
        <meta name="twitter:site" content="@mrdrozdov"/>
        <meta name="twitter:title" content={title}/>
        <meta name="twitter:description" content={description}/>

        <link rel="shortcut icon" href="/favicon.ico?v=00001" type="image/x-icon"/>
        <link rel="icon" href="/favicon.ico?v=00001" type="image/x-icon"/>


        <meta property="og:title" content={title}/>
        <meta property="og:type" content="article"/>
        <meta property="og:url" content="http://blog.mrdrozdov.com#{@props.page?.path}"/>
        <meta property="og:description" content={description}/>
        <meta property="og:site_name" content="A blog by Andrew Drozdov"/>
        <meta property="fb:admins" content="17830631"/>
        <TypographyStyle/>
        {css}
        <style dangerouslySetInnerHTML={{__html: """
          body {
            color: rgb(66,66,66);
          }
          h1,h2,h3,h4,h5,h6 {
            color: rgb(44,44,44);
          }
          a {
            color: rgb(42,93,173);
            text-decoration: none;
          }
        """}}/>
      </head>
      <body className="landing-page">
        <div id="react-mount" dangerouslySetInnerHTML={{__html: @props.body}} />
        <script src="/bundle.js"/>
        <script dangerouslySetInnerHTML={{__html: """
            (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
            (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
            m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
            })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

            ga('create', 'UA-79584451-1', 'auto');
            ga('send', 'pageview');
          """}}
        />

      </body>
    </html>
