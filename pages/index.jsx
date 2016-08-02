import React from 'react'
import {RouteHandler, Link} from 'react-router'
import sortBy from 'lodash/sortBy'

import access from 'safe-access'

import {rhythm} from 'blog-typography'
import {config} from 'config'

module.exports = React.createClass({
  displayName: {
    data: {
      yo: true
    }
  },

  render () {
    const pageLinks = []
    const sortedPages = sortBy(this.props.route.pages, (page) => access(page, 'data.date')).reverse()
      
    sortedPages.forEach((page) => {
      let title = access(page, 'data.title') || page.path
      if (access(page, 'path') && page.path !== "/" && !access(page, 'data.draft')) {
        pageLinks.push(
          <li
            key={page.path}
            style={{
              marginBottom: rhythm(1/4)
            }}
          >
            <Link to={page.path}>{title}</Link>
          </li>
        )
      }
    })

    return (
      <div>
        <ul>
          {pageLinks}
        </ul>


        <div>
          <a href="http://old-blog.mrdrozdov.com">Old Blog</a>
        </div>
      </div>
    )
  }
})
