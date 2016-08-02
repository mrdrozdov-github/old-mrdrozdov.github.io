import React from 'react'

module.exports = React.createClass({
    displayName: 'HTMLWrapper',
    render() {
        console.log(this.props)
        const html = `<div>fix me</div>`

        return (
            <div dangerouslySetInnerHTML={{__html: html}}/>
        );
    }
})
