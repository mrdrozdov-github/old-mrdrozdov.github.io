Feed = require('feed')
filter = require 'lodash/filter'
sortBy = require 'lodash/sortBy'
moment = require 'moment'
MarkdownIt = require 'markdown-it'
fs = require 'fs'
frontmatter = require 'front-matter'

md = MarkdownIt({
  html: true
  linkify: true
  typographer: true
})

module.exports = (pages, callback) ->
  console.log("running post-build")
  generateAtomFeed(pages)
  callback()

generateAtomFeed = (pages) ->
  feed = new Feed({
    title:       'Andrew Drozdov\'s Blog',
    description: 'A blog by Andrew Drozdov',
    link:        'http://mrdrozdov.com/',
    id:        'http://mrdrozdov.com/',
    copyright:   'All rights reserved 2016, Andrew Drozdov',
    author: {
      name:    'Andrew Drozdov',
      email:   'andrew@mrdrozdov.com',
    }
  })

  # Sort by date.
  pages = sortBy(pages, (page) -> page.data?.date).reverse()

  for page in filter(pages, (f) ->
    f.data?.title? and not f.data?.draft
  ).slice(0,10)
    feed.addItem({
      title: page.data.title
      id: "http://mrdrozdov.com#{page.path}"
      link: "http://mrdrozdov.com#{page.path}"
      date: moment(page.data.date).toDate()
      content: md.render(
        frontmatter(
          fs.readFileSync(
            "#{__dirname}/pages/#{page.requirePath}",
            'utf-8'
          )
        ).body
      )
      author: [{
        name: "Andrew Drozdov"
        email: "andrew@mrdrozdov.com"
        link: "http://mrdrozdov.com"
      }]
    })

  feed.addContributor({
    name: 'Andrew Drozdov'
    email: 'andrew@mrdrozdov.com'
    link: 'http://mrdrozdov.com'
  })

  fs.writeFileSync "#{__dirname}/public/atom.xml", feed.render('atom-1.0')
