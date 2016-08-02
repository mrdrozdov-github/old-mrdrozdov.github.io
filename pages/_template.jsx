import React from 'react'
import {RouteHandler, Link} from 'react-router'
import {Container, Grid, Breakpoint, Span} from 'react-responsive-grid'
import DocumentTitle from 'react-document-title'
import '../css/styles.css'

import {rhythm, fontSizeToMS} from 'blog-typography'
import {config} from 'config'

module.exports = React.createClass({
  render () {
    var header;
    if (this.props.location.pathname === "/") {
      header = (
        <h1
          style={{
            fontSize: fontSizeToMS(1).fontSize,
            lineHeight: fontSizeToMS(1).lineHeight,
            marginBottom: rhythm(1)
          }}
        >
          <Link
            style={{
              textDecoration: 'none',
              color: 'inherit'
            }}
            to="/"
          >
            {config.blogTitle}
          </Link>
        </h1>
      )
    } else {
      header = (
        <h3>
          <Link
            style={{
              textDecoration: 'none',
              color: 'inherit'
            }}
            to="/"
          >
            {config.blogTitle}
          </Link>
        </h3>
      )
    }

    return (
      <DocumentTitle title="Andrew Drozdov">
        <Container
          style={{
            minWidth: rhythm(28),
            maxWidth: rhythm(34),
            padding: `${rhythm(4)} ${rhythm(1/2)} ${rhythm(2)} ${rhythm(1/2)}`
          }}
        >
          {header}
          {this.props.children}
        </Container>
      </DocumentTitle>
      )
  }
})
