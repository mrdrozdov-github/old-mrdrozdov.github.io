React = require 'react'
require '../css/zenburn.css'
moment = require 'moment'
DocumentTitle = require 'react-document-title'
DisqusThread = require 'react-disqus-thread'

ReadNext = require '../components/ReadNext'
{rhythm} = require 'blog-typography'
{config} = require 'config'

module.exports = React.createClass
  displayName: "MarkdownWrapper"

  render: ->
    post = @props.route.page.data
    page = @props.route.page

    <DocumentTitle title="#{post.title} | Andrew Drozdov">
      <div className="markdown">
        <h3><a href="#{page.path}">{post.title}</a></h3>
        <small 
          style={{
            display: "block"
          }}>
          <span
            className="label label-primary"
            
          >{moment(post.date).format('YYYY.MM.DD')}</span>
        </small>
        <br/>
        <div dangerouslySetInnerHTML={{__html: post.body}}/>
        <hr
          style={{
            marginBottom: rhythm(2)
          }}
        />
        <ReadNext post={post} {...@props}/>
        <p
          style={{
            marginBottom: rhythm(6)
          }}
        >
          <img
            src="/me.jpg"
            style={{
              borderRadius: rhythm(1/4)
              float: 'left'
              marginRight: rhythm(1/4)
              marginBottom: 0
              width: rhythm(2)
              height: rhythm(2)
            }}
          />
          <strong>{config.authorName}</strong> likes to build things and help people. <a href="https://twitter.com/mrdrozdov">You should follow him on Twitter</a>
        </p>
        <DisqusThread
          shortname="mrdrozdov"
          title={post.title}
          url={"http://mrdrozdov.com#{@props.route.page.path}"}
        />
      </div>
    </DocumentTitle>
