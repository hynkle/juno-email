# juno-email

juno-convert is a tool for converting mail from the Juno email
client to the mbox format.

Once you have mbox files, you can import them into many mail programs,
such as [Thunderbird](http://www.mozilla.org/thunderbird/) (using the
excellent [ImportExportTools add-on](https://addons.mozilla.org/thunderbird/addon/importexporttools/))
or OS X's Mail app.


## Installation

    $ gem install juno-email


## Usage

tl;dr:

    $ juno-convert --source path/to/juno --destination path/for/output

Details:

    juno-convert [options]
       -s, --source           Path to Juno directory. Required.
       -d, --destination      Path to output directory. Required.
       -o, --overwrite        Overwrite files in output directory.
       -v, --version          Display version.
       -h, --help             Display this help message.

More details:

* `--source` is the path in which the user folders are located.  They look
like USER0000, USER0001, etc.
* `--destination` is where you want the mbox files to be output.  If destination
is `foo/bar`, `bar` will be created if it doesn't already exist.
* `--overwrite` means that if the program wants to create `foo.mbox` and there's
already a `foo.inbox` there, it wil be overwritten. Without this option, the
program will abort if it runs into such a situation.

## It doesn't work!!

The tool needs Ruby 1.9 or greater.  You can check your version with `ruby -v`.

That's not the problem? Okay, let's make things better!  I only had access to
one user's emails from Juno 4.0.11, so I can easily believe there are plenty
of edge cases I haven't run across.  If you could [open an issue](https://github.com/hynkle/juno-email/issues/new)
with as much detail as you have, we can get started on figuring it out and
making this tool better for everyone.  Be sure to include your operating system
and your ruby version (`ruby -v`).


## Contributing

1. Fork it ( http://github.com/<my-github-username>/juno/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
