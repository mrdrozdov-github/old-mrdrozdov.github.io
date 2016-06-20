React = require 'react'
Router = require 'react-router'
{RouteHandler, Link} = Router
sortBy = require 'lodash/sortBy'

{rhythm} = require 'blog-typography'
{config} = require 'config'

module.exports = React.createClass
  statics:
    data: ->
      yo: true

  render: ->
    pageLinks = []
    for page in sortBy(@props.route.pages, (page) -> page.data?.date).reverse()
      title = page.data?.title || page.path
      if page.path? and page.path isnt "/" and not page.data?.draft
        pageLinks.push (
          <li
            key={page.path}
            style={{
              marginBottom: rhythm(1/4)
            }}
          >
            <Link to={page.path}>{title}</Link>
          </li>
        )

    <div>
      <p
        style={{
          marginBottom: rhythm(2.5)
        }}
      >
      </p>
      <ul>
        {pageLinks}
      </ul>
    </div>
