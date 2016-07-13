React = require 'react'
Router = require 'react-router'
{RouteHandler, Link} = Router
{Container, Grid, Breakpoint, Span} = require 'react-responsive-grid'
DocumentTitle = require 'react-document-title'
require '../css/styles.css'

{rhythm, fontSizeToMS} = require 'blog-typography'
{config} = require 'config'

module.exports = React.createClass
  render: ->
    if @props.location.pathname is "/"
      header = (
        <h1
          style={{
            fontSize: fontSizeToMS(1).fontSize
            lineHeight: fontSizeToMS(1).lineHeight
            marginBottom: rhythm(1)
          }}
        >
          <Link
            style={{
              textDecoration: 'none'
              color: 'inherit'
            }}
            to="/"
          >
            {config.blogTitle}
          </Link>
        </h1>
      )
    else
      header = (
        <h3>
          <Link
            style={{
              textDecoration: 'none'
              color: 'inherit'
            }}
            to="/"
          >
            {config.blogTitle}
          </Link>
        </h3>
      )

    <DocumentTitle title="Andrew Drozdov">
      <Container
        style={{
          minWidth: rhythm(28)
          maxWidth: rhythm(34)
          padding: "#{rhythm(4)} #{rhythm(1/2)} #{rhythm(2)} #{rhythm(1/2)}"
        }}
      >
        {header}
        {this.props.children}
      </Container>
    </DocumentTitle>
