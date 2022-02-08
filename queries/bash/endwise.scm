((if_statement "then" @cursor) @endable @indent (#endwise! "fi"))
((do_group "do" @cursor) @endable @indent (#endwise! "done"))
((case_statement "in" @cursor) @endable @indent (#endwise! "esac"))
