/*
 * The MIT License (MIT)
 *
 * Copyright (c) 2020-2022 Polystat.org
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */
package org.polystat;

import org.cactoos.list.ListOf;
import com.jcabi.xml.XML;
import org.cactoos.Func;
import org.polystat.far.FaR;

/**
 * Bridge to FaR analysis module.
 *
 * @see <a href="https://github.com/polystat/far">GitHub</a>
 * @since 0.4
 */
public final class AnFaR implements Analysis {

    @Override
    public Iterable<Result> errors(final Func<String, XML> xmir,
        final String locator) {
        try {
            Iterable<String> errors = new FaR().errors(xmir, locator);
            return new ListOf<>(new Result.Completed(AnFaR.class, errors));
        } catch (final Exception e) {
            return new ListOf<>(new Result.Failed(AnFaR.class, e));
        }
    }

}
