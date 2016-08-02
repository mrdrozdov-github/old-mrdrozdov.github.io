import React from 'react'
import '../css/zenburn.css'
import moment from 'moment'

import DocumentTitle from 'react-document-title'
import DisqusThread from 'react-disqus-thread'

import ReadNext from '../components/ReadNext'
import {rhythm} from 'blog-typography'
import {config} from 'config'

module.exports = React.createClass({
  displayName: 'MarkdownWrapper',

  render() {
    var post = this.props.route.page.data;
    var page = this.props.route.page;

    return (
      <DocumentTitle title={ `${post.title} | Andrew Drozdov` }>
        <div className="markdown">
          <h3><a href={ `${page.path}` }>{post.title}</a></h3>
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
          <ReadNext post={post} {...this.props}/>
          <p
            style={{
              marginBottom: rhythm(6)
            }}
          >
            <img
              src="/me.jpg"
              style={{
                borderRadius: rhythm(1/4),
                float: 'left',
                marginRight: rhythm(1/4),
                marginBottom: 0,
                width: rhythm(2),
                height: rhythm(2)
              }}
            />
            <strong>{config.authorName}</strong> likes to build things and help people. <a href="https://twitter.com/mrdrozdov">You should follow him on Twitter</a>
          </p>
          <DisqusThread
            shortname="mrdrozdov"
            title={post.title}
            url={ `http://mrdrozdov.com${this.props.route.page.path}` }
          />
        </div>
      </DocumentTitle>
    )
  }
})
